# Reference: https://github.com/Azure-Samples/virtual-machines-powershell-create/blob/master/PowerShell/RMCreateVM.ps1
function Fetch-AzureRmVMImageInfos() {
    param
    (
        [string]
        $RmProfilePath = $(throw "Parameter missing: -RmProfilePath RmProfilePath"),
        [string]
        $LocationName = $(throw "Parameter missing: -Location Location"),
        [string]
        $PublisherName = 'Microsoft',
        [string]
        $OfferName = 'windows'
    )
    Select-AzureRmProfile –Path $RmProfilePath -ErrorAction Stop
    $Location = Get-AzureRmLocation | Where-Object { $_.Location -eq $LocationName }
    If (-not($Location)) { Throw "The location does not exist." }
    $PublisherName = '*' + $PublisherName + '*'
    $OfferName = '*' + $OfferName + '*'
    $lstPublishers = Get-AzureRMVMImagePublisher -Location $LocationName | Where-object { $_.PublisherName –like $PublisherName }
    ForEach ($pub in $lstPublishers) {
        #Get the offers
        $lstOffers = Get-AzureRMVMImageOffer -Location $LocationName -PublisherName $pub.PublisherName | Where-object { $_.Offer –like $OfferName }
        ForEach ($off in $lstOffers) {
            Get-AzureRMVMImageSku -Location $LocationName -PublisherName $pub.PublisherName -Offer $off.Offer | Format-Table -Auto
        }
    }
}

#Check location
function Check-AzureRmLocation() {
    param
    (
        [string]
        $LocationName = $(throw "Parameter missing: -LocationName LocationName")
    )
    Write-Host "Check location $LocationName" -ForegroundColor Green
    $Location = Get-AzureRmLocation | Where-Object { $_.Location -eq $LocationName }
    If (-not($Location)) {
        Write-Host "The location" $LocationName "does not exist." -ForegroundColor Red
        return $false
    }
    Else {
        return $true
    }
}

#Check resource group, if not, created it.
function Check-AzureRmResourceGroup() {
    param
    (
        [string]
        $ResourceGroupName = $(throw "Parameter missing: -ResourceGroupName ResourceGroupName"),
        [string]
        $LocationName = $(throw "Parameter missing: -LocationName LocationName")
    )
    Write-Host "Check resource group $ResourceGroupName, if not, created it." -ForegroundColor Green
    Try {
        $ResourceGroup = Get-AzureRmResourceGroup -Name $ResourceGroupName -Location $LocationName -ErrorAction Stop
        If (-not($ResourceGroup)) {
            Write-Host "Creating resource group" $ResourceGroupName "..." -ForegroundColor Green
            New-AzureRmResourceGroup -Name $ResourceGroupName -Location $LocationName  -ErrorAction Stop
            return $true
        }
        Else {
            return $true
        }
    }
    Catch {
        Write-Host -ForegroundColor Red "Create resource group" $LocationName "failed." $_.Exception.Message
        return $false
    }
}

#Auto generate store account.
function AutoGenerate-AzureRmStorageAccount() {
    param
    (
        [string]
        $ResourceGroupName = $(throw "Parameter missing: -ResourceGroupName ResourceGroupName"),
        [string]
        $LocationName = $(throw "Parameter missing: -LocationName LocationName")
    )

    while ($true) {
        $RandomNum = Get-Random -minimum 100 -maximum 999
        $Prefix = $ResourceGroupName -replace "-", ""
        $Prefix = $Prefix.ToLower()
        # Storage account name must be between 3 and 24 characters in length and use numbers and lower-case letters only.
        $StorageAccountName = $Prefix + "disks" + $RandomNum
        Try {
            $IsAvailability = Get-AzureRmStorageAccountNameAvailability -Name $StorageAccountName -ErrorAction Stop
            If ($IsAvailability) {
                Write-Host "Auto generate store account $StorageAccountName" -ForegroundColor Green
                $StorageAcc = New-AzureRmStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -SkuName "Standard_LRS" -Kind "Storage" -Location $LocationName  -ErrorAction Stop
                return $StorageAcc.PrimaryEndpoints.Blob.ToString()
            }
        }
        Catch {
            Write-Host -ForegroundColor Red "Auto generate storage account failed" $_.Exception.Message
            return $false
        }
    }
}

#Auto generate network interface.
function AutoGenerate-AzureRmNetworkInterface() {
    param
    (
        [string]
        $ResourceGroupName = $(throw "Parameter missing: -ResourceGroupName ResourceGroupName"),
        [string]
        $LocationName = $(throw "Parameter missing: -LocationName LocationName"),
        [string]
        $VMName = $(throw "Parameter missing: -VMName VMName")
    )

    Try {
        $RandomNum = Get-Random -minimum 100 -maximum 999
        $SubnetName = "subnetdefault" + $RandomNum
        $VnetName = $ResourceGroupName + "-vnet" + $RandomNum
        $IpName = $VMName + "-ip" + $RandomNum
        $NicName = $VMName + "-ni" + $RandomNum

        Write-Host "Auto generate network interface $NicName" -ForegroundColor Green

        $Subnet = New-AzureRmVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix 10.0.0.0/24 -ErrorAction Stop
        $Vnet = New-AzureRmVirtualNetwork -Name $VnetName -ResourceGroupName $ResourceGroupName -Location $LocationName -AddressPrefix 10.0.0.0/16 -Subnet $Subnet -ErrorAction Stop

        $Pip = New-AzureRmPublicIpAddress -Name $IpName -ResourceGroupName $ResourceGroupName -Location $LocationName -AllocationMethod Dynamic -ErrorAction Stop

        $Nic = New-AzureRmNetworkInterface -Name $NicName -ResourceGroupName $ResourceGroupName -Location $LocationName -SubnetId $Vnet.Subnets[0].Id -PublicIpAddressId $Pip.Id -ErrorAction Stop

        return $Nic.Id
    }
    Catch {
        Write-Host -ForegroundColor Red "Auto generate network interface" $_.Exception.Message
        return $false
    }
}

#Create a Windows VM using Resource Manager
function New-AzureVMByRM() {
    param
    (
        [string]
        $RmProfilePath = $(throw "Parameter missing: -RmProfilePath RmProfilePath"),
        [string]
        $ResourceGroupName = $(throw "Parameter missing: -ResourceGroupName ResourceGroupName"),
        [string]
        $LocationName = $(throw "Parameter missing: -LocationName LocationName"),
        [string]
        $VMName = $(throw "Parameter missing: -VMName VMName"),
        [string]
        $VMSizeName = "Standard_DS1",
        [string]
        $PublisherName = 'MicrosoftVisualStudio',
        [string]
        $OfferName = 'Windows',
        [string]
        $SkusName = '10-Enterprise-N',
        [string]
        $UserName = 'frank',
        [string]
        $Password = 'Frank@12345678'

    )

    Try {
        #1. Login Azure by profile or Login-AzureRmAccount
        #Login-AzureRmAccount
        #Save-AzureRmProfile -Path “C:\PS\azureaccount.json”
        Write-Host "Login Azure by profile" -ForegroundColor Green
        Select-AzureRmProfile –Path $RmProfilePath -ErrorAction Stop

        #2. Check location
        if (Check-AzureRmLocation -LocationName $LocationName) {
            #3. Check resource group, if not, created it.
            if (Check-AzureRmResourceGroup -LocationName $LocationName -ResourceGroupName $ResourceGroupName) {
                #4. Check VM images
                Write-Host "Check VM images $SkusName" -ForegroundColor Green
                If (Get-AzureRMVMImageSku -Location $LocationName -PublisherName $PublisherName -Offer $OfferName -ErrorAction Stop | Where-Object { $_.Skus -eq $SkusName }) {
                    #5. Check VM
                    If (Get-AzureRmVM -Name $VMName -ResourceGroupName $ResourceGroupName -ErrorAction Ignore) {
                        Write-Host -ForegroundColor Red "VM $VMName has already exist."
                    }
                    else {
                        #6. Check VM Size
                        Write-Host "check VM Size $VMSizeName" -ForegroundColor Green
                        If (Get-AzureRmVMSize -Location $LocationName | Where-Object { $_.Name -eq $VMSizeName }) {
                            #7. Create a storage account
                            $BlobURL = AutoGenerate-AzureRmStorageAccount -Location $LocationName -ResourceGroupName $ResourceGroupName
                            If ($BlobURL) {
                                #8. Create a network interface
                                $Nid = AutoGenerate-AzureRmNetworkInterface -Location $LocationName -ResourceGroupName $ResourceGroupName -VMName $VMName
                                If ($Nid) {
                                    Write-Host "Creating VM $VMName ..." -ForegroundColor Green

                                    #10.Set the administrator account name and password for the virtual machine.
                                    $StrPass = ConvertTo-SecureString -String $Password -AsPlainText -Force
                                    $Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ($UserName, $StrPass)

                                    #11.Choose virtual machine size, set computername and credential
                                    $VM = New-AzureRmVMConfig -VMName $VMName -VMSize $VMSizeName -ErrorAction Stop
                                    $VM = Set-AzureRmVMOperatingSystem -VM $VM -Windows -ComputerName $VMName -Credential $Cred -ProvisionVMAgent -EnableAutoUpdate -ErrorAction Stop

                                    #12.Choose source image
                                    $VM = Set-AzureRmVMSourceImage -VM $VM -PublisherName $PublisherName -Offer $OfferName -Skus $SkusName -Version "latest" -ErrorAction Stop

                                    #13.Add the network interface to the configuration.
                                    $VM = Add-AzureRmVMNetworkInterface -VM $VM -Id $Nid -ErrorAction Stop

                                    #14.Add storage that the virtual hard disk will use.
                                    $BlobPath = "vhds/" + $SkusName + "Disk.vhd"
                                    $OSDiskUri = $BlobURL + $BlobPath
                                    $DiskName = "windowsvmosdisk"
                                    $VM = Set-AzureRmVMOSDisk -VM $VM -Name $DiskName -VhdUri $OSDiskUri -CreateOption fromImage -ErrorAction Stop

                                    #15. Create a virtual machine
                                    New-AzureRmVM -ResourceGroupName $ResourceGroupName -Location $LocationName -VM $VM -ErrorAction Stop
                                    Write-Host "Successfully created a virtual machine $VMName" -ForegroundColor Green
                                }
                            }
                        }
                        Else {
                            Write-Host -ForegroundColor Red "VM Size $VMSizeName does nott exist."
                        }

                    }
                }
                Else {
                    Write-Host -ForegroundColor Red "VM images does not exist."
                }
            }
        }

    }
    Catch {
        Write-Host -ForegroundColor Red "Create a virtual machine $VMName failed" $_.Exception.Message
        return $false
    }
}


New-AzureVMByRM  -ResourceGroupName ocoslab-tanyue -LocationName eastasia -VMName vm-frta-test01 -RmProfilePath C:\Work\PS\azureaccount.json