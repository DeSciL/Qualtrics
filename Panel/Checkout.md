# Checkout with Custon End of Survey Question

In Qualtrics, go to the tab 'Library' > Toolbar 'Message Library' and create a new message. 
Chose Category 'End of Survey Message' and add 'Mturk Checkout' as a description.
Paste the text below into the text field and format as you please. As soon as the message 
is saved, you can choose it under tab 'Edit Surveys' > toolbox 'Survey Options' > section
'Survey Termination' by ticking the option 'Custom end of survey message' and selecting
your template. Such a template could look like this:


     Checkout

     You have finished the study. Thank you for taking your time! 
     In order to receive your payment you must copy and paste the 
     following redemption code back to Amazon Mechanical Turk:

     ${m://LastName}

     Your payment will be processed within the next 24 hours. 
     If you encounter problems submitting this HIT, please search 
     for a HIT called "ETH Descil Trouble Ticket" and report your 
     problem there.