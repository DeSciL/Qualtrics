###################################################################################################
# Generate a Descil HIT Definition File
# stwehrli@gmail.com
# 29sept2015

# Source directly from GitHub into PowerShell:
# $url = "https://raw.githubusercontent.com/DeSciL/Qualtrics/master/Hits/HitDefinition.ps1"
# iex ((new-object net.webclient).DownloadString($url))
#
###################################################################################################
<# 
 .SYNOPSIS 
  Utils to setup HIT definitions 

 .DESCRIPTION
  Utils to setup HIT definitions. The following functions are implemented:
  
  - New-HITDefinition
  - Set-HITDefinition
  - Export-HITDefinition
  - Import-HITDefinition
  - ConvertTo-HITDefinition
  
 .LINK
  https://github.com/descil/qualtrics/hits
#> 
function about_HITDefinitionSetup{}

# Call this on load
help about_HITDefinitionSetup

###################################################################################################
function New-HITDefinition {
<# 
 .SYNOPSIS 
  Create a HIT definition

 .DESCRIPTION
  Creates a HIT definition file ready to upload 
  to the DeSciL Mturk Service.

 .PARAMETER File
  Specifies the name of the file to save the HIT ticket.
  
 .EXAMPLE
  New-HitDefinition
#>  
    Param(
        [Parameter(Position=0, Mandatory=$false)]
        [string]$File="HitDefinition.json"
    ) 

    $Global:AmtHd = New-Object Amt.Data.HITDefinition
    return $HitDefinition
}

###################################################################################################
function Set-HITDefinition {
<# 
 .SYNOPSIS 
  Set attributes of HIT definition.

 .DESCRIPTION
  Set attributes of HIT definition.
  
 .LINK
  about_HITDefinition
#>    
    Param(
      [Parameter(Position=0, Mandatory=$false)]
		  [int]$ProjectId,
      [Parameter(Position=0, Mandatory=$false)]
		  [int]$Assignments,
      [Parameter(Position=0, Mandatory=$false)]
		  [double]$Reward,
      #[Parameter(Position=0, Mandatory=$false)]
		  #[bool]$Sandbox,
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$HitTitle,
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$HitDescription,
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$HitKeywords,
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$HitDisclaimer,
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$HitInstructions,
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$HitCode,
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$TreatmentUrl,
      [Parameter(Position=0, Mandatory=$false)]
		  [int]$HitDuration,
      [Parameter(Position=0, Mandatory=$false)]
		  [int]$HitLifeTime,
      [Parameter(Position=0, Mandatory=$false)]
		  [int]$AutoApprovalDelay,
      [Parameter(Position=0, Mandatory=$false)]
		  [int]$PreviousMode,
      [Parameter(Position=0, Mandatory=$false)]
		  [int]$CheckoutMode,
      [Parameter(Position=0, Mandatory=$false)]
		  [int]$BatchMode,
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$Annotation,
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$QualCountry,
      [Parameter(Position=0, Mandatory=$false)]
		  [int]$QualMinApproval,
      [Parameter(Position=0, Mandatory=$false)]
		  [int]$QualMinSubmitted,
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$QualExclude,
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$QualInclude,
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$QualIncludeComparer,
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$QualIncludeVal,
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$TroubleTicketHITId
	   )
     
     TestAmtData
     
     if(!($Global:HITDefinition)) {
         $Global:HITDefinition = New-HITDefinition
     }
 
		 if($ProjectId) { $HITDefinition.ProjectId = $ProjectId}
		 if($Assignments) { $HITDefinition.Assignments = $Assignments}
		 if($Reward) { $HITDefinition.Reward = $Reward}
		 if($HitTitle) { $HITDefinition.HitTitle = $HitTitle}
		 if($HitDescription) { $HITDefinition.HitDescription = $HitDescription}
		 if($HitKeywords) { $HITDefinition.HitKeywords = $HitKeywords}
		 if($HitDisclaimer) { $HITDefinition.HitDisclaimer = $HitDisclaimer}
		 if($HitInstructions) { $HITDefinition.HitInstructions = $HitInstructions}
		 if($HitCode) { $HITDefinition.HitCode = $HitCode}
		 if($TreatmentUrl) { $HITDefinition.TreatmentUrl = $TreatmentUrl}
		 if($HitDuration) { $HITDefinition.HitDuration = $HitDuration}
		 if($HitLifeTime) { $HITDefinition.HitLifeTime = $HitLifeTime}
		 if($AutoApprovalDelay) { $HITDefinition.AutoApprovalDelay = $AutoApprovalDelay}
		 if($PreviousMode) { $HITDefinition.PreviousMode = $PreviousMode}
		 if($CheckoutMode) { $HITDefinition.CheckoutMode = $CheckoutMode}
		 if($BatchMode) { $HITDefinition.BatchMode = $BatchMode}
		 if($Annotation) { $HITDefinition.Annotation = $Annotation}
		 if($QualCountry) { $HITDefinition.QualCountry = $QualCountry}
		 if($QualMinApproval) { $HITDefinition.QualMinApproval = $QualMinApproval}
		 if($QualMinSubmitted) { $HITDefinition.QualMinSubmitted = $QualMinSubmitted}
		 if($QualExclude) { $HITDefinition.QualExclude = $QualExclude}
		 if($QualInclude) { $HITDefinition.QualInclude = $QualInclude}
		 if($QualIncludeComparer) { $HITDefinition.QualIncludeComparer = $QualIncludeComparer}
		 if($QualIncludeVal) { $HITDefinition.QualIncludeVal = $QualIncludeVal}
		 if($TroubleTicketHITId) { $HITDefinition.TroubleTicketHITId = $TroubleTicketHITId}

     return $HITDefinition  
}

###################################################################################################
function Export-HitDefinition {
<# 
 .SYNOPSIS 
  Export HIT defintion to JSON
  
 .DESCRIPTION
  Export HIT defintion to JSON

 .PARAMETER HitDefinition
  Specifies the HIT definition object

 .PARAMETER Path
  Specifies the path to the JSON file to export.
  
 .EXAMPLE
  Export-HitDefinition -H $hd -F myHitDef.json
  
 .LINK
  about_PsAmtData
#>
	Param(
		[Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$True)]
		$HitDefinition,
		[Parameter(Position=1, Mandatory=$false)]
		[string]$Path = "#Annotation#-#HId#.json"
	)
	
  TestAmtData
	$json = ConvertTo-Json $HitDefinition
	$Path = $Path.Replace("#Annotation#", $HitDefinition.Annotation)
	$Path = $Path.Replace("#HId#", $HitDefinition.HId)
	Out-File -FilePath $Path -InputObject $json
	$json
}

###################################################################################################
function Import-HitDefinition {
<# 
 .SYNOPSIS 
  Import HIT defintion from JSON
  
 .DESCRIPTION
  Import HIT defintion from JSON

 .PARAMETER Path
  Specifies the path to the JSON file containing the HIT definition.
  
 .EXAMPLE
  Import-HitDefinition -F myHitDef.json
  
 .LINK
  about_PsAmtData
#>
	Param(
		[Parameter(Position=0, Mandatory=$true)]
		[string]$Path
	)
	
  TestAmtData
	$json = Get-Content $Path | Out-String
	$hitDefinitionObject = ConvertFrom-Json $json
	$Global:HITDefinition = ConvertTo-HITDefinition $hitDefinitionObject
	$Global:HITDefinition
}

###################################################################################################
function ConvertTo-HITDefinition {
<# 
 .SYNOPSIS 
  Convert to proper HIT definition object
  
 .DESCRIPTION
  Convert to proper HIT definition object

 .PARAMETER HitDefinitionObject
  Specifies the HIT definition as a PSObject
  
 .EXAMPLE
  ConvertTo-HitDefinition -H $hdo
  
 .LINK
  about_PsAmtData
#>
	Param(
		[Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$True)]
		$HitDefinitionObject
	)
  
  TestAmtData
	$ho = $HitDefinitionObject
	$hd = New-Object Amt.Data.HitDefinition
	$hd.HId = $ho.HId
	$hd.ProjectId = $ho.ProjectId
	if($ho.CreationTime -eq $null) {
		$hd.CreationTime = (Get-Date)
	} else {
		$hd.CreationTime = $ho.CreationTime
	}
	$hd.HITId = $ho.HITId
	$hd.HITTypeId = $ho.HITTypeId
	$hd.Assignments = $ho.Assignments
	$hd.Reward = $ho.Reward
	$hd.Sandbox = $ho.Sandbox
	$hd.HitTitle = $ho.HitTitle
	$hd.HitDescription = $ho.HitDescription
	$hd.HitKeywords = $ho.HitKeywords
	$hd.HitDisclaimer = $ho.HitDisclaimer
	$hd.HitInstructions = $ho.HitInstructions
	$hd.HitCode = $ho.HitCode
	$hd.TreatmentUrl = $ho.TreatmentUrl
	$hd.HitDuration = $ho.HitDuration
	$hd.HitLifetime = $ho.HitLifetime
	$hd.AutoApprovalDelay = $ho.AutoApprovalDelay
	$hd.PreviousMode = $ho.PreviousMode
	$hd.CheckoutMode = $ho.CheckoutMode
	$hd.BatchMode = $ho.BatchMode
	$hd.Annotation = $ho.Annotation
	$hd.QualCountry = $ho.QualCountry
	$hd.QualMinApproval = $ho.QualMinApproval
	$hd.QualMinSubmitted = $ho.QualMinSubmitted
	$hd.QualExclude = $ho.QualExclude
	$hd.QualInclude = $ho.QualInclude
	$hd.QualIncludeComparator = $ho.QualIncludeComparator
	$hd.QualIncludeValue = $ho.QualIncludeValue
	$hd.TroubleTicketHITId = $ho.TroubleTicketHITId
	$hd
}

###################################################################################################
function TestAmtData {}

###################################################################################################
# Some Types in C# to make life easier

Add-Type -Language CSharp @"

namespace Amt.Data
{
    using System;
    using System.Collections.Generic;
    
    /// <summary>
    /// HIT definition class
    /// </summary>
    public class HitDefinition
    {
        public int HId { get; set; }
        public int ProjectId { get; set; }
        public DateTime CreationTime { get; set; }
        public string HITId { get; set; }
        public string HITTypeId { get; set; }
        public int Assignments { get; set; }
        public double Reward { get; set; }
        public bool Sandbox { get; set; }
        public string HitTitle { get; set; }
        public string HitDescription { get; set; }
        public string HitKeywords { get; set; }
        public string HitDisclaimer { get; set; }
        public string HitInstructions { get; set; }
        public string HitCode { get; set; }
        public string TreatmentUrl { get; set; }
        public int HitDuration { get; set; }
        public int HitLifeTime { get; set; }
        public int AutoApprovalDelay { get; set; }
        public int PreviousMode { get; set; }
        public int CheckoutMode { get; set; }
        public int BatchMode { get; set; }
        public string Annotation { get; set; }
        public string QualCountry { get; set; }
        public int QualMinApproval { get; set; }
        public int QualMinSubmitted { get; set; }
        public string QualExclude { get; set; }
        public string QualInclude { get; set; }
        public string QualIncludeComparator { get; set; }
        public string QualIncludeValue { get; set; }
        public string TroubleTicketHITId { get; set; }
    
        // CTOR
        public HitDefinition() {
            CreationTime = DateTime.Now;
            HITId = "";
            HITTypeId = "";
            Reward = 0;
            Sandbox = true;
            HitCode = Guid.NewGuid().ToString("n").ToUpper();
            HitDuration = 3600;
            HitLifeTime = 259200;
            AutoApprovalDelay = 1296000;
            PreviousMode = 0;
            CheckoutMode = 1;
            BatchMode = 0;
        }
    }
}
"@

###################################################################################################
# Set Aliases
###################################################################################################