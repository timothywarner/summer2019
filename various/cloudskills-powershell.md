# CloudSkills Azure PowerShell

April 25, 2019

Tim Warner

* [Twitter](https://twitter.com/techtrainertim)
* [Website](https://techtrainertim.com)

---

## Develop Azure PowerShell Locally with PowerShell Core and Visual Studio Code

Let's learn how to migrate from the deprecated PowerShell ISE to VSCode!

### Set up your environment

* Install [PowerShell Core](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-6)
* Install [Git](https://git-scm.com/)
* Install [Visual Studio Code](https://code.visualstudio.com/)

### Get VSCode ready to rock

* Install the [PowerShell extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell)
* Install the [Azure Account extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account)
* Install the [Azure Resource Manager Tools ](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools)extension
* Install [VSCode icons](https://marketplace.visualstudio.com/items?itemName=vscode-icons-team.vscode-icons)
* * Install the [Shell Launcher extension](https://marketplace.visualstudio.com/items?itemName=Tyriar.shell-launcher)

### Pop in your snippets

* [PowerShell snippets](https://rkeithhill.wordpress.com/2015/09/12/powershell-snippets-for-visual-studio-code/)
* [Azure Resource Manager snippets](https://marketplace.visualstudio.com/items?itemName=samcogan.arm-snippets)

### Tweak your VSCode and PowerShell settings

```JSON
{

    "workbench.iconTheme": "material-icon-theme",
    "workbench.startupEditor": "newUntitledFile",
    "workbench.editor.showIcons": true,
    "workbench.editor.tabSizing": "shrink",
    "workbench.colorTheme": "Cobalt Blue",

    "editor.mouseWheelZoom": true,
    "editor.minimap.enabled": false,
    "editor.renderWhitespace": "all",
    "editor.renderControlCharacters": true,
    "editor.wordWrap": "on",
    "editor.formatOnType": true,
    "editor.tabCompletion": "on",
    "editor.formatOnPaste": true,
    "editor.wordBasedSuggestions": false,
    "editor.fontSize": 10,

    "files.trimTrailingWhitespace": true,
    "files.autoSave": "afterDelay",
    "files.defaultLanguage": "Plain Text",

    "terminal.integrated.fontFamily": "Consolas",
    "terminal.integrated.fontSize": 18,
    "terminal.integrated.lineHeight": 1,
    "terminal.integrated.shell.windows": "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
    "powershell.powerShellExePath": "C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
    "files.associations": {
        "*.ps1": "powershell"
    },

      //  "terminal.integrated.shell.windows": "c:/Program Files/PowerShell/6/pwsh.exe",
        "shellLauncher.shells.windows": [
            {
                "shell": "c:\\Program Files\\PowerShell\\6\\pwsh.exe",
                "label": "PowerShell Core"
            },
            {
                "shell": "C:\\Windows\\system32\\WindowsPowerShell\\v1.0\\powershell.exe",
                "label": "PowerShell Desktop"
            }
        ],

    "powershell.enableProfileLoading": true,
    "powershell.integratedConsole.focusConsoleOnExecute": true,
    "powershell.integratedConsole.showOnStartup": false,

    "sync.gist": "b0974b1cc61e9c3d3f93401506823845",
    // "sync.host": "",
   //  "sync.pathPrefix": "",
    "sync.quietSync": false,
    "sync.askGistName": false,
    "sync.removeExtensions": true,
    "sync.syncExtensions": true,
    "sync.autoDownload": false,
    "sync.autoUpload": false,
  //  "sync.lastUpload": "2018-08-19T20:15:14.741Z",
  // "sync.lastDownload": "2018-08-12T14:55:46.607Z",
    "sync.forceDownload": false,

    "git.autofetch": true,
    "git.enableSmartCommit": true,
    "azure.resourceFilter": [
        "133f6972-44a7-4037-8eea-1d9afd1ebfc8/2fbf906e-1101-4bc0-b64f-adc44e462fff"
    ]
}
```

### Customize your keyboard shortcuts

```JSON
// command palette
workbench.action.showCommands

// run selected text
workbench.action.terminal.runSelectedText
```

## PowerShell Dev Workflow with Git and GitHub

blah

## ARM Template Development and Deployment

* [Visual Studio Community](https://visualstudio.microsoft.com/vs/community/)
* [Azure Quickstart Templates](https://azure.microsoft.com/en-us/resources/templates/)
* [Deploy a storage account](https://github.com/Azure/azure-quickstart-templates/tree/master/101-storage-account-create)
* [Protect secret in ARM template](https://github.com/Azure/azure-quickstart-templates/tree/master/101-vm-secure-password)
* [Deploy multiple VMs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-multiple)

### If we have time...
* [Passing parameters as objects in ARM templates](https://github.com/mspnp/template-examples/tree/master/example3-object-param)
* [Subscription-scoped deployments](https://docs.microsoft.com/en-us/azure/azure-resource-manager/deploy-to-subscription)
