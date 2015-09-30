# Qualtrics

Setup of Qualtrics for surveys and experiments at ETH DeSciL

### 1. Panel Setup

Integration with Qualtrics is built on a simple code-sharing procedure. 
Respondents access the survey by click on a link. The link has an embedded access code (password).
After having completed the survey or experiment, an exit code (redemption code) is displayed on the last page.
The worker has to transfer this exit code with copy and paste to Amazon Mechnical Turk.
This procedure is very robust and easy to understand for turkers.

- See script [QualtricsPanel.ps1](Panel/QualtricsPanel.ps1) for details how to create a panel.
- See file [Checkout](Panel/Checkout.md) for instructions to setup a 'Custom end of survey message'.
- See file Factorial (tba) for instructions to setup a panel with predefined factorial designs 

### 2. HIT Definition 

- More details and instructions (tba)
- See file [HitDefinition.json](Hits/HitDefinition.json) for details.
- See script [HitDefinition.ps1](Hits/HitDefinition.ps1) to process definition files.

### 3. Informed Consent

The cornerstone of "ethical proof" data collection is to aquire informed consent from the respondent before you start your data collection. 
Find some examples we have used in previous studies below. We recommend to add 'informed consent' forms infront of all your surveys.

- [Consent Form](Consent/Consent.md)
- Data protection rules (tba)

### 4. Supported research designs

- Cross-section from AMT posting
- Repeated cross-section without retakes (trend)
- Panel design, repeated measurement with e-mail reminders
- Scheduled pool recruitment for real-time games [in preparation]

### 5. Advanced

- Hosting web assets (javascript, images) on DeSciL on-premises or cloud servers
- Routing/Chaining of different treatments
- JavaScript WebService for IAT (AJAX)
- WebService Checkin/Checkout for real-time treatments
- Automatic data exports/transforms

### License

[MIT](LICENSE)
