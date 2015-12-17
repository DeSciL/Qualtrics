# HITs

A HIT is a Human Inteligence Task on Amazon Mechnical Turk. HITs for surveys typically 
have `n` assignements where `n` corresponds to the number of survey particpants.
Submitting a HIT requires a set of meta data which describe the HIT, make it 
discoverable on Mturk, and specifies its lifetime (title, description, keyworkds).
HIT Qualifications can be added to restrict access based on turker's attributes 
or their history of completed HITs. Finally, detailed instructions can be provided.

To run your HITs, DesciL staff expects a set these files which specifiy your HIT. Let's call the HIT `Study1`.

1. `Study1-HITDefinition.json`: A key-value paired list of HIT properties.
2. `Study1-HITInstructions.html`: A HTML-Fragment gives detailed information and instructions to the worker.
3. `Study1-Codes.csv`: A CSV file with access and exit codes where the former protects your survey and latter proves task completion for the worker. 



---

#### 1. HIT Definition

The simplest way to create a HIT definition is to modify the file with a text editor. A minimal version of the JSON looks the following:

     {
		"Annotation":  "Study1",
		"Assignments":  10,
		"Reward":  1.00,
		"HitDuration":  3600,
		"HitTitle":  "Study on decision making",
		"HitDescription":  "Make choices between several options and receive a bonus up to USD 1.",
		"HitKeywords":  "survey, decision making, scientific study",
		"TreatmentUrl":  "https://qualtrics.com/?#accessCode#",
		"QualCountry":  "US",
      }
	  
A full version of the HIT definition is [HitDefinition.json](HitDefinition.json), the minimal version is here: [HitDefinition-Mini.json](HitDefinition-mini.json). Additionally, 
the following PowerShell script [HitDefinition.ps1](HitDefinition.ps1) might help to create, validate, and submit your definition. It can be sourced directly with:

     # Copy this to PowerShell
     $url = "https://raw.githubusercontent.com/DeSciL/Qualtrics/master/Hits/HitDefinition.ps1"
	 iex ((new-object net.webclient).DownloadString($url))
     help about_HITDefinition

#### 2. HIT Instructions

On the HIT previw page on Mturk we display your `<div />`. Instructions will be rendered with [twitter boostrap](http://getbootstrap.com/). 

     <div>
		<p><b>Purpose of the study:</b> To understand decision making processes</p> 
		<p><b>What you will do:</b> If you decide to participate, you will fill out a questionnaire. <p>  
		<p><b>Time required:</b>  The study will take approximately 15 minutes to complete.</p>    
		<p><b>Risks:</b> There are no anticipated risks associated with participating in this study.</p>  
		<p><b>Compensation:</b> You will receive USD 1 for participating.</p>
		<p><b>Support:</b> In case trouble, search for a HIT called 'ETH Trouble Ticket'.</p>
	 </div>
	 
#### 3. Sampling, Exclusion, and Inclusion Criteria

There are several ways to control access to your survey based on turkers' characteristics. 
Access is typically controlled with Mturk qualifications. First of all, there are the built-in qualifications.

- Locale Qualification (e.g., US, US-NY, IN, or combinations.)
- PercentAssignmentsApproved (e.g. > 95%)
- NumberHITsApproved (e.g., > 1000 HITs completed)
- Masters, Worker_Adult (restrict to professionals)

Additionally, we can setup our own qualifications based on explicit qualification tests or data from previous encounters.
We could, for example, exclude all turkers who have participated in a similiar study or who have completed the HITs too fast. 
On the other hand, we can explicitly include turkers and only grant access if they have participated in a previous measurement wave. 

- Exclude Qualification
- Include Qualification

Finally, we maintain a very small profile of demographic variables on the majority of workers who have completed our HITs. 
This allows basic forms of quota sampling and preconfigured interactions based on socio-demographics. 
Please discuss all questions regarding sampling with DeSciL staff.

#### 4. Code Sharing

See [Panel Setup](../Panel/Panel.md).
