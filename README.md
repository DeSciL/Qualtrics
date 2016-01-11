# Qualtrics

Setup Qualtrics for surveys and experiments in the lab and on Amazon Mechanical Turk. 
This is preliminary material. Please help us to improve this documentation.

### 1. Panel Setup

Running surveys on Mturk can easily be accomplished with a panel in Qualtrics. 
A panel is essentially an address list that stores passwords and redemption codes. 
Turkers access the survey with personalized links and have to copy/paste the redemption code from the last survey page back to Mturk. 
This panel file has to be submitted to DeSciL staff.

- See [Panel](Panel/Panel.md) for more details. 

### 2. HIT Definition

The HIT definition assembles all required information to upload a HIT to Amazon Mechanical Turk, like title, description, reward, and number of assignments. 
Just make sure that you submit all required data in any format you like. If you plan to run a lot of HITs, we invite you to submit proper
HIT definitions as a JSON files.  

- See [HITs](Hits/Hits.md) for more details.

### 3. Informed Consent

Best strategy of "ethical proof" data collection is to aquire informed consent from the respondent before you start your data collection. 
Find some examples we have used in previous studies below. We recommend adding such a form in front of all your surveys.

- [Consent Form](Consent/Consent.md)

### 4. Supported Research Designs

We post HITs with command line tools (PsAmt) against the Amazon Mechanical Turk Web API. In theory, this allows us to support the following research designs: 

- Cross-section from AMT posting (most common scenario)
- Repeated cross-section without retakes (trend study)
- Panel design, repeated measurement with e-mail reminders and qualifications
- DeSciL pool recruitment to speed up data collection and select on previously collected socio-demographic data (quota sampling) [in beta]
- Scheduled pool recruitment for real-time games [in beta]

### 5. Integration / Add-ons

- [WebService](Integration/Integration.md) Checkin/Checkout for real-time treatments
- Hosting [web assets](Integration/Hosting.md) (javascript, images) on DeSciL on-premises or cloud servers
- PHP scripts for [Factorial Surveys](Integration/Factorial/)
- JavaScript WebService for implicit association tests / IAT (AJAX based) [in beta]

### License

[MIT](LICENSE)
