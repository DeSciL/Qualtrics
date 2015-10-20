# Qualtrics

Setup Qualtrics for surveys and experiments in the lab and on Amazon Mechanical Turk.

### 1. Panel Setup

Running a surveys on Mturk can easily be accomplished with a panel in Qualtrics. A panel is essentially an address list that stores passwords and redemption codes. Turkers access the survey with personalized links and have to copy/paste the redemption code from the last survey page back to Mturk. From the panel, finally, one can compile a code list which has to be submitted to DeSciL staff.

- See [Panel](Panel/Panel.md) for more details. 

### 2. Mturk HIT Definition

The HIT definition assembles all required information to upload a HIT to Mturk, like title, description, reward, and number of assignments. The HIT definition can be submitted as a JSON file.  

- See [HITs](Hits/Hits.md) for more details.

### 3. Informed Consent

Best strategy of "ethical proof" data collection is to aquire informed consent from the respondent before you start your data collection. 
Find some examples we have used in previous studies below. We recommend adding such a form in front of all your surveys.

- [Consent Form](Consent/Consent.md)

### 4. Supported Research Designs

We post HITs with command line tools (PsAmt) against the Amazon Mechanical Turk Web API. In theory, this enables us to support the following research designs: 

- Cross-section from AMT posting
- Repeated cross-section without retakes (trend)
- Panel design, repeated measurement with e-mail reminders
- DeSciL pool recruitment to speed up data colletion time
- Scheduled pool recruitment for real-time games [in beta]

### 5. Miscellaneous

- Hosting [web assets](Misc/Hosting.md) (javascript, images) on DeSciL on-premises or cloud servers
- [WebService](Misc/WebService.md) Checkin/Checkout for real-time treatments
- PHP Scripts for [Factorial Surveys](Misc/Factorial/)
- JavaScript WebService for IAT (AJAX) [in beta]
- [Faq](Misc/Faq.md)

### License

[MIT](LICENSE)
