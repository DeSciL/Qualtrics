# Qualtrics Panels

Integration with Qualtrics is built on a simple code-sharing procedure. Respondents access the survey by click on a link. The link has an embedded access code (aka password). After having completed the survey or experiment, an exit code (aka redemption code) is displayed on the last page. The worker has to transfer this exit code with copy & paste to Amazon Mechnical Turk. This procedure is very robust and easy to understand for turkers.

Prerequisite is a panel file (aka participant list with passwords) which needs 5 steps to create:

1. Download our PowerShell script 
2. Create a list with exit codes (exit list)
3. Upload exit codes into a Qualtrics panel
4. Link your survey to the panel and generate an access link list.
5. Create the code list 

---

### 1. Download a PowerShell script

Paste these two line of code in a PowerShell. This should give you access to 
two functions:  `New-QualtricsPanel` and `Get-CodesFromQualtricsPanel`. 
Type `help about_QualtricsPanel` for details.
    
     $url = "https://raw.githubusercontent.com/DeSciL/Qualtrics/master/Panel/QualtricsPanel.ps1"
     iex ((new-object net.webclient).DownloadString($url))

### 2. Create a list with exit codes (exit list)

The function below will create a CSV File 

     New-QualtricsPanel -Panelists 20 -Path "myPanel.csv"

with the following format:

| FirstName  | LastName | PrimaryEmail     | ExternalDataReference | ... |
|----------- |:--------:|:----------------:|:---------------------:| ---:|
| 1          | oqHh6... | info@nomail.com  | oqHh6FDxeSTRec3       | ... |
| 2          | zZEPX... | info@nomail.com  | zZEPXySucUcmk2b       | ... |
| ...        | ...      | ...              | ...                   | ... |

The exit codes are now stored in the fields LastName and ExternalDataReference.
You can add additional panel variable as EmbeddedDataA-EmbeddedDataZ to control the flow of your survey (not displayed here). 

### 3. Upload exit codes into a Qualtrics panel

### 4. Link your survey to the panel and generate an access link list.

### 5. Create the code list

### Misc

- See script [QualtricsPanel.ps1](QualtricsPanel.ps1) for details how to create a panel.
- See file [Checkout](Checkout.md) for instructions to setup a 'Custom end of survey message'.
- See file Factorial (tba) for instructions to setup a panel with predefined factorial designs



