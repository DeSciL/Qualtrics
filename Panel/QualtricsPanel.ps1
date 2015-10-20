###################################################################################################
# Generate a Code List from a Qualtrics Panel
# stwehrli@gmail.com
# 6jul2015

# Source from PowerShell
# Navigate into the directory with the .ps1 file and dotsource it
# . ./QualtricsPanel.ps1

# Source directly from Github into PowerShell:
# $url = "https://raw.githubusercontent.com/DeSciL/Qualtrics/master/Panel/QualtricsPanel.ps1"
# iex ((new-object net.webclient).DownloadString($url))

###################################################################################################
<# 
 .SYNOPSIS 
  Utils to setup a Qualtrics Panel

 .DESCRIPTION
  This script contains five functions that may be helpful in creating
  a code list based on a Qualtrics panel. The following functions are
  implemented:
  
  - about_QualtricsPanel:        This help file
  - about_QualtricsPanelSetup:   List of required steps
  - New-QualtricsPanel:          Create "exit code" list
  - Get-CodesFromQualtricsPanel: Create code list
  - Get-RandomString:            Creates passwords (internal)
  
  You can type 'help funcName' for detailed help on one of functions.
  Type 'help about_QualtricsPanelSetup' for detailed steps.
  
 .EXAMPLE
  help about_QualtricsPanelSetup
  
  Displays detailed instructions for the panel setup.
  
 .EXAMPLE
  New-QualtricsPanel -Panelists 100 -Path Study1-ExitCodes.csv
  
 .EXAMPLE
  Get-CodesFromQualtricsPanel -Path Study1-AccessCodes.csv -OutPath Study1-Codes.csv
  
 .LINK
  https://github.com/descil/qualtrics

#>
function about_QualtricsPanel {}

# Call this function on load!
help about_QualtricsPanel

###################################################################################################
<# 
 .SYNOPSIS 
  Setup a Qualtrics Panel

 .DESCRIPTION
  Five steps to setup a Qualtrics panel and control access to surveys:
  
  - Create exit codes
  - Load exit codes into a Qualtrics panel
  - Link the survey to the panel and generate survey access links.
  - Extract the code file
  - Add a 'Custom end of survey message' to display the exit code
  
  1) First you have to create a csv file that contains exit codes. 
  
  > New-QualtricsPanel -Panelists 20 -Path "myPanel.csv"
    
  The function below will create a CSV File with the following format:
  
  FirstName, LastName, PrimaryEmail, ExternalDataReference,	...
  1, oqHh6FDxeSTRec3, info@no-mail.com, oqHh6FDxeSTRec3,	...	
  2, zZEPXySucUcmk2b, info@no-mail.com, zZEPXySucUcmk2b,	...	
  
  The exit codes are now stored in the fields LastName and ExternalDataReference.
  You can add additional panel variable as EmbeddedDataA-EmbeddedDataZ 
  to control the flow of your survey (not displayed here).  

  2) In a second step, this file must be imported into a new Qualtrics panel. 
  In Qualtrics click on the tab 'Panels'. Then click on the green button on the
  right side to create a new panel. Name the panel similar to your survey.
  Then click on 'Import From a File'. Click browse and choose your CSV file. 
  In the dialog 'Import/Update From a File' just click import.
  
  3) In the third step, the survey must be linked to the panel. First select 
  your survey, go to 'Survey Options' (in the toolbar) and tick the option 
  'By Invitation only' under 'Survey Protection'. Save Changes. Then click
  on the tab 'Distribute Survey' Activate your survey. Below the yellow box, 
  click on 'Generate Links'. Select the panel from your library, and 'Select 
  Entire Panel'. Then click on 'Generate Links'. This will generate a 
  downloadable CSV that contains the survey access links. Rename this file
  to 'MyPanelLinks.csv'.
  
  4) In step four, you have to extract the access codes (passwords) and exit 
  codes and merge them into a DeSciL code file with the following function:
  
  > Get-CodesFromQualtricsPanel -Path "MyPanelLinks.csv"
    
  This will generate the final code file (MyPanelLinks-Codes.csv) 
  you have to submit to DeSciL staff.
  
  5) The last step is to display the exit codes on the last page of your survey. 
  Go to the tab 'Library' > toolbar 'Message Library' and create a new message. 
  Chose Category 'End of Survey Message' and add 'Mturk Checkout' as a description. 
  Paste the text below into the text field and format as you please. As soon as the 
  message is saved, you can choose it under tab 'Edit Surveys' > toolbox 
  'Survey Options' > section 'Survey Termination' by ticking the option 
  'Custom end of survey message' and selecting your template.  
#>
function about_QualtricsPanelSetup {}

###################################################################################################
function New-QualtricsPanel {
<# 
 .SYNOPSIS 
  Create a new Qualtrics panel

 .DESCRIPTION
  Create a new Qualtrics panel with exit codes. The columns of the panels
  are sligly abused:

  FirstName:             Id
  LastName:              ExitCode
  PrimaryEmail:          A valid or invliad email address
  ExternalDataReference: ExitCode again
  EmbeddedDataA:         Additional panel attributes
  EmbeddedDataB:         Additional panel attributes
  
 .PARAMETER Panelist
  Specifies the number of participants the panel should hold.
  
 .PARAMETER Path
  Specifies the path to the CSV file containing the panel.
  
 .PARAMETER Delimiter
  Specifies the delimiter for Import-CSV

 .EXAMPLE
  New-QualtricsPanel -Panelists 100 -Path mypanel.csv
  
 .LINK
  about_QualtricsPanel
#> 
    Param(
        [Parameter(Position=0, Mandatory=$true)]
        [int]$Panelists,
        [Parameter(Position=1, Mandatory=$false)]
        [string]$Path="ExitCodes.csv",
        [Parameter(Position=1, Mandatory=$false)]
        [string]$Delimiter=","
    )
  
    $qualtricsPanel = New-Object QualtricsPanel
    for ($i = 0; $i -lt $Panelists; $i++)
    { 
        $qualtricsPanel.AddPanelist(($i+1).ToString(), (Get-RandomString 15))
    }
    $qualtricsPanel.Panel | Export-Csv -Path $Path -Delimiter $Delimiter -NoTypeInformation -Encoding UTF8
    Write-Host "Panel file '$Path' created at " (Get-ChildItem $Path).FullName
}

###################################################################################################
function Get-CodesFromQualtricsPanel {
<# 
 .SYNOPSIS 
  Create a code list

 .DESCRIPTION
  Create a code list extracted from CSV with generated access links.
  
 .PARAMETER Path
  Specifies the path to the CSV file containing the access codes.
 
 .PARAMETER OutPath
  Specifies the path to the CSV of the final code file.
 
 .PARAMETER Delimiter
  Specifies the delimiter for Import-CSV
  
 .EXAMPLE
  Get-CodesFromQualtricsPanel -Path mypanel.csv
#> 
    Param(
        [Parameter(Position=0, Mandatory=$true)]
        [string]$Path,
        [Parameter(Position=1, Mandatory=$false)]
        [string]$OutPath = $Path.Replace(".csv", "-Codes.csv"),
        [Parameter(Position=2, Mandatory=$false)]
        [string]$Delimiter = ","
    )
  
    $qualtricsPanel = New-Object QualtricsPanel
    $panelists = Import-Csv -Path $Path -Delimiter $Delimiter
    foreach($p in $panelists) {
        $exitCode = $p.'Last Name'
        $accessCode = $qualtricsPanel.GetAccessCode($p.Link)
        $link = $qualtricsPanel.GetAccessLink($p.Link)
        $qualtricsPanel.AddCode($accessCode, $exitCode)
    }

    $numCodes = $qualtricsPanel.Codes.Count
    $qualtricsPanel.Codes | Export-Csv -Path $OutPath -NoTypeInformation -Encoding UTF8
    Write-Output "Created codelist with $numCodes codes: '$codeFilePath'"
    Write-Output "Access Link: $link"
}

###################################################################################################
function Get-RandomString  {
<# 
 .SYNOPSIS 
  Get random string

 .DESCRIPTION
  Returns a random string of specified length used for access and exit codes.
  
 .EXAMPLE
  Get-RandomString 10
#>
  
    Param(
        [Parameter(Position=0, Mandatory=$false)]
        [int]$Length=15
    )
  
    $sourcedata = "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9"
    for ($loop=1; $loop –le $length; $loop++) {
        $password+=($sourcedata | Get-Random)
    }
    return $password
}

###################################################################################################
# Some Types in C# to make life easier
# - Panelist
# - Code
# - QualtricsPanel

Add-Type -Language CSharp @"

using System.Collections.Generic;

/// <summary>
/// Minimal panelist object
/// </summary>
public class Panelist
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string PrimaryEmail { get; set; }
    public string ExternalDataReference { get; set; }
    public string EmbeddedDataA { get; set; }
    public string EmbeddedDataB { get; set; }

    // Convenience CTOR
    public Panelist(string firstName, string lastName)
    {
        FirstName = firstName;
        LastName = lastName;
        PrimaryEmail = "info-" + firstName + "@no-mail.com";
        ExternalDataReference = lastName;
    }
}

/// <summary>
/// Object to hold access and exit codes
/// </summary>
public class Code
{
    public string AccessCode { get; set; }
    public string ExitCode { get; set; }
    public string Id { get; set; }

    // Convenience CTOR
    public Code(string accessCode, string exitCode, int id)
    {
        AccessCode = accessCode;
        ExitCode = exitCode;
    }
}

/// <summary>
/// Panel object with list of panelist and codelist
/// </summary>
public class QualtricsPanel
{
    public List<Panelist> Panel;
    public List<Code> Codes;

    // CTOR
    public QualtricsPanel()
    {
        Panel = new List<Panelist>();
        Codes = new List<Code>();
    }

    /// <summary>
    /// Add a panelist
    /// </summary>
    /// <param name="firstName">The id of the panelist</param>
    /// <param name="lastName">The exit code of the panelist</param>
    public void AddPanelist(string firstName, string lastName)
    {
        var p = new Panelist(firstName, lastName);
        Panel.Add(p);
    }

    /// <summary>
    /// Add a code to the list of codes
    /// </summary>
    /// <param name="accessCode">An access code</param>
    /// <param name="exitCode">An exit code</param>
    public void AddCode(string accessCode, string exitCode)
    {
        var id = Codes.Count + 1;
        var c = new Code(accessCode, exitCode, id);
        Codes.Add(c);
    }

    /// <summary>
    /// Add a code to the list of codes
    /// </summary>
    /// <param name="accessCode">An access code</param>
    /// <param name="exitCode">An exit code</param>
    /// <param name="id">A sequence id</param>
    public void AddCode(string accessCode, string exitCode, int id)
    {
        var c = new Code(accessCode, exitCode, id);
        Codes.Add(c);
    }

    /// <summary>
    /// Return access code from survey link
    /// </summary>
    /// <param name="link">Survey link</param>
    /// <returns>Access code</returns>
    public string GetAccessCode(string link)
    {
        var pos = link.IndexOf("_MLRP_");
        link = link.Substring(pos).Replace("_MLRP_", "").Trim();
        
        //Strip any query strings after code
        if(link.IndexOf("&") >= 0)
        {
            link = link.Substring(0, link.IndexOf("&")).Trim();
        }
        return link;
    }

    /// <summary>
    /// Return trimmed survey link
    /// </summary>
    /// <param name="link">Survey link</param>
    /// <returns>Survey link without access code</returns>
    public string GetAccessLink(string link)
    {
        // TODO: Generalize
        // Check if there are additional query strings
        if(link.IndexOf("&") >= 0)
        {
            var qs = link.Substring(link.IndexOf("&")+1);
            link = link.Replace("SE?Q_DL", "SE?" + qs + "&Q_DL");
        }
        var pos = link.IndexOf("_MLRP_");
        return link.Substring(0, pos + 6).Trim();
    }

    /// <summary>
    /// Clear list of panelists and codes
    /// </summary>
    public void Clear()
    {
        Panel.Clear();
        Codes.Clear();
    }
}
"@

###################################################################################################