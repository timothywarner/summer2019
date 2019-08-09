<#┌─────────────────────────────────────────────────────────────────────────────────────────────┐
  │ UNICODE COMMENT SNIPPETS                                                                    │
  └─────────────────────────────────────────────────────────────────────────────────────────────┘#>

<#┌─────────────────────────────────────────────────────────────────────────────────────────────┐
  │ FUNCTION TEMPLATE                                                                           │
  └─────────────────────────────────────────────────────────────────────────────────────────────┘#>

<#
.SYNOPSIS


.DESCRIPTION


.NOTES
┌──────────────────────────────────────────────────────────────────────┐
│ ORIGIN STORY                                                         │
├──────────────────────────────────────────────────────────────────────┤
│   DATE        : yyyy.mm.dd                          │
│   AUTHOR      : __AUTHOR_NAME__                   │
│   DESCRIPTION : Initial Draft                  │
└──────────────────────────────────────────────────────────────────────┘

.PARAMETER Param01
__DESC_PARAM01__

.PARAMETER Param02
__DESC_PARAM02__

.EXAMPLE

foo `
  -Param01 'Hello' `
  -Param02 'World' | oh

#>

function foo
  {
    [OutputType([String])]
    [CmdletBinding()]
    Param
      (
          [Parameter(Mandatory = $true)]
          [String]$Param01

        , [Parameter(Mandatory = $false)]
          [String]$Param02
      )

    return "$Param01 $Param02"

    <# TODO: Add you function code here #>

  }

<#┌─────────────────────────────────────────────────────────────────────────────────────────────┐
  │ __SECTION_TITLE_100__                                                                       │
  └─────────────────────────────────────────────────────────────────────────────────────────────┘#>

<#┌────────────────────────────────────────────────────────────────────┐
  │ __SECTION_TITLE_075__                                              │
  └────────────────────────────────────────────────────────────────────┘#>

<#┌───────────────────────────────────────────┐
  │ __SECTION_TITLE_050__                     │
  └───────────────────────────────────────────┘#>





<#┌─────────────────────────────────────────────────────────────────────────────────────────────┐
  │ ANSI/OEM COMMENT SNIPPETS                                                                   │
  └─────────────────────────────────────────────────────────────────────────────────────────────┘#>

<#
.SYNOPSIS


.DESCRIPTION


.NOTES
+---------------------------------------------------------------------------------------------+
| ORIGIN STORY                                                                                |
+---------------------------------------------------------------------------------------------+
|   DATE        : yyyy.mm.dd
|   AUTHOR      : __AUTHOR_NAME__
|   DESCRIPTION : Initial Draft
+---------------------------------------------------------------------------------------------+

.PARAMETER Param01
__DESC_PARAM01__

.PARAMETER Param02
__DESC_PARAM02__

.EXAMPLE

foo `
  -Param01 'Hello' `
  -Param02 'World' | oh

#>

function foo
  {
    [OutputType([String])]
    [CmdletBinding()]
    Param
      (
          [Parameter(Mandatory = $true)]
          [String]$Param01

        , [Parameter(Mandatory = $false)]
          [String]$Param02
      )

    return "$Param01 $Param02"

    <# TODO: Add you function code here #>

  }

<#+---------------------------------------------------------------------------------------------+
  | __SECTION_TITLE_100__                                                                       |
  +---------------------------------------------------------------------------------------------+#>

<#+--------------------------------------------------------------------+
  | __SECTION_TITLE_075__                                              |
  +--------------------------------------------------------------------+#>

<#+-------------------------------------------+
  | __SECTION_TITLE_050__                     |
  +-------------------------------------------+#>



<#┌────────────────────────────────────────────────────────────────────┐
  │ Try-Catch block with nested exception reporting                    │
  └────────────────────────────────────────────────────────────────────┘#>

try
  {
    #Do Stuff
  }
catch
  {
   "Stuff Failed" | Write-Error

    $ExceptionLevel   = 0
    $BagroundColorErr = 'DarkRed'
    $e                = $_.Exception
    $Msg              = "[$($ExceptionLevel)] {$($e.Source)} $($e.Message)"
    $Msg.PadLeft($Msg.Length + (2*$ExceptionLevel)) | Write-Host -ForegroundColor Yellow -BackgroundColor $BagroundColorErr
    $Msg.PadLeft($Msg.Length + (2*$ExceptionLevel)) | Write-Output

    while($e.InnerException)
      {
        $ExceptionLevel++
        if($ExceptionLevel % 2 -eq 0)
          {
            $BagroundColorErr = 'DarkRed'
          }
        else
          {
            $BagroundColorErr='Black'
          }

        $e = $e.InnerException

        $Msg = "[$($ExceptionLevel)] {$($e.Source)} $($e.Message)"
        $Msg.PadLeft($Msg.Length + (2*$ExceptionLevel)) | Write-Host -ForegroundColor Yellow -BackgroundColor $BagroundColorErr
        $Msg.PadLeft($Msg.Length + (2*$ExceptionLevel)) | Write-Output
    }
  }
