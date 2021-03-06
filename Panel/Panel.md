# Qualtrics Panels

Integration with Qualtrics is built on a simple code-sharing procedure. Respondents access the survey by click on a link. 
We start your survey in a new tab and ask turkers to keep the Mturk browser tab open.The link has an embedded `access code` (aka password):

     https://qualtrics.com/SE?Q_CHL=gl&Q_DL=xxxxxxxxxxxxxxx_MLRP_#accessCode#
     
After having completed the survey or experiment, an exit code (aka redemption code) is displayed on the last page of your survey. 
The worker has to transfer this exit code with copy & paste back to Amazon Mechnical Turk. 
This procedure is not very sophisticated. However, it turned out to be very robust and easy to understand for turkers.
In the following, we describe how we setup our panel files. Of course, this can also be done manually without the scripts we provide. 

Prerequisite is a panel file (aka participant list with passwords) which needs 6 steps to create:

1. Download our PowerShell script 
2. Create a list with exit codes (exit list)
3. Upload exit codes into a Qualtrics panel
4. Link your survey to the panel and generate unique survey links (access codes)
5. Create the final code list 
6. Display exit codes
7. Submit the list to DeSciL Staff

---

#### 1. Download a PowerShell script

Paste these two line of code in a PowerShell. This should give you access to 
some functions:  `New-QualtricsPanel` and `Get-CodesFromQualtricsPanel`. 
Type `help about_QualtricsPanel` for details.
    
     $url = "https://raw.githubusercontent.com/DeSciL/Qualtrics/master/Panel/QualtricsPanel.ps1"
     iex ((new-object net.webclient).DownloadString($url))
     
Notes:
- See script [QualtricsPanel.ps1](QualtricsPanel.ps1) for details.

#### 2. Create a list with exit codes (exit list)

The function below will create a CSV File for a HIT called 'Survey1'.

     New-QualtricsPanel -Panelists 20 -Path "Survey1-ExitCodes.csv"

with the following format:

| FirstName  | LastName        | PrimaryEmail        | ExternalDataReference | ... |
|----------- |:---------------:|:-------------------:|:---------------------:| ---:|
| 1          | oqHh6FDxeSTRec3 | info-1@no-mail.com  | oqHh6FDxeSTRec3       | ... |
| 2          | zZEPXySucUcmk2b | info-2@no-mail.com  | zZEPXySucUcmk2b       | ... |
| ...        | ...             | ...                 | ...                   | ... |

The exit codes are now stored in the fields LastName and ExternalDataReference.

Note: 
- You can add additional panel variable as EmbeddedDataA-EmbeddedDataZ to control the flow of your survey, 
i.e., you can show or hide survey questions or pages based values you specify in the panel file.

#### 3. Upload exit codes into a Qualtrics panel

In a thrid step, this file must be imported into a new Qualtrics panel. 
In Qualtrics click on the tab 'Panels'. Then click on the green button on the
right side to create a new panel. Name the panel similar to your survey.
Then click on 'Import From a File'. Click browse and choose your CSV file. 
In the dialog 'Import/Update From a File' just click import.

#### 4. Link your survey to the panel and generate unique survey links

In a fourth step, the survey must be linked to the panel. First select 
your survey, go to 'Survey Options' (in the toolbar) and tick the option 
'By Invitation only' under 'Survey Protection'. Save Changes. Then click
on the tab 'Distribute Survey' Activate your survey. Below the yellow box, 
click on 'Generate Links'. Select the panel from your library, and 'Select 
Entire Panel'. Then click on 'Generate Links'. See link under Notes for screenshots where to find it.
This will generate a downloadable CSV file that contains the survey access links. Rename this file
to 'Survey1-AccessCodes.csv'.

The CSV file sould have the following format:

|ResponseID|Last Name      | First Name |External Data Reference| Email            | Status           | End Date |Link                                                                                        |
|----------|:-------------:|:----------:|:---------------------:|:----------------:|:----------------:|:--------:|-------------------------------------------------------------------------------------------:|
|          |oqHh6FDxeSTRec3| 1          | oqHh6FDxeSTRec3       |info-1@no-mail.com|Email not sent yet|          | https://qualtrics.com/SE?Q_DL=d5U5xtya6O4qRsx_bJCd470RvVdYdtq_MLRP_9LhzQEynM9hxafP&Q_CHL=gl|
|          |zZEPXySucUcmk2b| 2          | zZEPXySucUcmk2b       |info-2@no-mail.com|Email not sent yet|          | https://qualtrics.com/SE?Q_DL=d5U5xtya6O4qRsx_bJCd470RvVdYdtq_MLRP_8v2pKycBjrB60e1&Q_CHL=gl|

Access codes will be extracted from the links. The part behind the segment `_MLRP_` is the access code.

Notes:
- [Generating Unique Survey Links](http://www.qualtrics.com/university/researchsuite/distributing/more-distribution-methods/generating-unique-survey-links/)

#### 5. Create the final code list

In step five, you have to extract the access codes (passwords) and exit 
codes and merge them into a DeSciL code file with the following function:

     Get-CodesFromQualtricsPanel -Path "Survey1-AccessCodes.csv"

This will generate the final code file "Survey1-Codes.csv" which should have a format similar to the following:

|AccessCode      | ExitCode        |
|----------------|-----------------|
|9LhzQEynM9hxafP | oqHh6FDxeSTRec3 |
|8v2pKycBjrB60e1 | zZEPXySucUcmk2b |
|...             | ...             |

Additionally, the prodedure writes out a text file "Survey1-Link.txt" where the access link to the survey is stored.

#### 6. Dispay exit codes

Turkers arrive on your survey with one of the links in Survey1-AccessCodes.csv. At the end of 
the survey you have to display a message that contains the corresponding exit code.

- See the file [Checkout](Checkout.md) for instructions on how to setup a 'Custom end of survey message'.

#### 7. Submit

Just submit the codelist and the link file together with the HIT Ticket to DeSciL Staff and we are ready to run your survey within 24-48 hours.
