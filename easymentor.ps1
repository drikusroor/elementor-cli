param(
  [Parameter(Position = 0, Mandatory = $True)]
  [ValidateSet("plugin", "widget")]
  [string]$Command
)

$WorkingDirectory = $pwd

function Find-Directory([String]$SearchContext, [String]$Keyword) {
  $FoundDirectory = Get-ChildItem $SearchContext -Filter $Keyword -Recurse -Directory
  return $FoundDirectory
}

function New-Plugin {

  $WpContentDir = Find-Directory $WorkingDirectory 'wp-content';

  $PluginsSearchDirectory = $WorkingDirectory
  
  if ($WpContentDir.Count -gt 0) {
    $PluginsSearchDirectory = $WpContentDir[0]
  }
  
  $WpPluginsResult = Find-Directory $PluginsSearchDirectory 'plugins';
  $ShouldCreateDirectoryInRoot = 0 # 0 equals false, 0 equals true

  $WpPluginsDir = $pwd
  
  if ($WpPluginsResult -eq 0) {
    $Title = "No plugins directory found. Would you like to create the plugin in the current working directory?"
    $WpPluginsDir = $WorkingDirectory
    $Yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Description."
    $Cancel = New-Object System.Management.Automation.Host.ChoiceDescription "&Cancel", "Description."
    $Options = [System.Management.Automation.Host.ChoiceDescription[]]($Cancel, $Yes)
    
    $ShouldCreateDirectoryInRoot = $host.UI.PromptForChoice($Title, $message, $Options, 1)
    
    if ($ShouldCreateDirectoryInRoot -eq 0) {
      Write-Host "Canceled creating plugin."
      return
    }
  }
  else {
    $WpPluginsDir = $WpPluginsResult[0]
  }
  
  $PluginName = Read-Host 'What is the name of the plugin?'

  Write-Host($WpPluginsDir, $PluginName)
  
  $NewDirectoryPath = $WpPluginsDir + '\' + $PluginName


  # New-Item -Path $NewDirectoryPath -ItemType Directory

}

function New-Widget {
  $WidgetName = Read-Host 'What is the name of the widget?'
  Write-Host($WidgetName)
}

switch ($Command) {
  "plugin" { New-Plugin }
  "widget" { New-Widget }
}