# Qualtrics

Setup Qualtrics for surveys and experiments on Amazon Mechanical Turk.

### 1. Panel Setup

Running a surveys on Mturk can easily be accomplished with a panel in Qualtrics. A panel is essentially an address list that stores passwords and redemption codes. Turkers access the survey with personalized links and have to copy/paste the redemption code from the last survey page back to Mturk. From the panel, finally, one can compile a code list which has to be submitted to DeSciL staff.

- See [Panel](Panel/Panel.md) for more details. 

### 2. Mturk HIT Definitions

The HIT definition assembles all required information to upload a HIT to Mturk, like title, description, reward, and number of assignments. The HIT definition can be submitted as a JSON file.  

- See [HITs](Hits/Hits.md) for more details.

### 3. Informed Consent

The cornerstone of "ethical proof" data collection is to aquire informed consent from the respondent before you start your data collection. 
Find some examples we have used in previous studies below. We recommend to add 'informed consent' forms in front of all your surveys.

- [Consent Form](Consent/Consent.md)

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
