###############################################################################
# Generate a Descil HIT Definition File
# stwehrli@gmail.com
# 29sept2015

# Source directly from GitHub into PowerShell:
# $url = "https://raw.githubusercontent.com/DeSciL/Qualtrics/master/HitDefinition.ps1"
# iex ((new-object net.webclient).DownloadString($url))

###############################################################################
<# 
 .SYNOPSIS 
  Create a HIT ticket

 .DESCRIPTION
  Creates a HIT definition file ready to upload 
  to the DeSciL Mturk Service.

 .PARAMETER File
  The name of the file to save the HIT ticket
  
 .EXAMPLE
  New-HitDefinition
#>
function New-HITDefinition {
    Param(
        [Parameter(Position=0, Mandatory=$false)]
        [string]$File="HitDefinition.json"
    ) 

    $ht = New-Object HitTicket
    $ht.HId = 0
    $ht.ProjectId = 0
    $ht.CreationTime = [DateTime]::Now
    
    $ht.Assignments = 10
    $ht.Reward = 1.00
    $ht.HitTitle = 'Survey on decision making'
    $ht.HitDescription = ''
    $ht.HitKeywords = 'survey, decision making, scientific study'
    $ht.HitDisclaimer = ''
    $ht.HitInstructions = ''
    $ht.HitCode = ''
    $ht.TreatmentUrl = ''
    $ht.Folder = ''
    $ht.QualCountry = ''
    $ht.QualPriv = ''
    $ht.QualPrivComparer = ''
    $ht.QualPrivVal = ''

    $json = ConvertTo-Json -InputObject $ht
    $json | Out-File $File
}

###############################################################################
<# 
 .SYNOPSIS 
  Import a HIT ticket

 .DESCRIPTION
  Import a HIT definition from JSON and convert it to a HIT definition object.
  
 .EXAMPLE
  Import-HitDefinition -File HitDefinition.json
#>
function Import-HITDefinition {
    Param(
      [Parameter(Position=0, Mandatory=$false)]
		  [string]$File="HitDefinition.json"
	   ) 
    
    $json  = Get-Content $File | Out-String
    return ConvertFrom-Json -InputObject $json
}

###############################################################################
# Some Types in C# to make life easier

Add-Type -Language CSharp @"

using System;
using System.Collections.Generic;

/// <summary>
/// HIT definition class
/// </summary>
public class HitTicket
{
    public int HId { get; set; }
    public int ProjectId { get; set; }
    public DateTime CreationTime { get; set; }
    public string HitId { get; set; }
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
    public string Folder { get; set; }
    public string QualCountry { get; set; }
    public int QualMinApproval { get; set; }
    public int QualMinSubmitted { get; set; }
    public string QualPriv { get; set; }
    public string QualPrivComparer { get; set; }
    public string QualPrivVal { get; set; }

    // CTOR
    public HitTicket() {}
}
"@

###############################################################################