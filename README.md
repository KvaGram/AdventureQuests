# Welcome to Tenebrae Adventure guild quests ONLINE

##My todo list
* program the add item event feature
* design and program the set variable feature
* design and program the item condition feature
* design and program the variable condition feature


## Here to help?
### How to add audio to a dialogue

1. Open up Audacity.
2. Either record the audio into audacity, or load the audio into it.
3. For each line of dialouge:
    3a. Make sure the select tool is selected, top left in the 2x3 button panel next to record (this is default, but goofs happen)
    3b. Select the audio for the line
    3c. Add a label (ctrl + b) or (edit -> Labels -> Add Label at Selection)
    3d. Adjust the label areas to fit right
    3e. label-text is optional, add as you see fit
4. save the project in case future changes are needed.
5. export the labels (File -> Export -> Export Labels...)
6. export the audio, if not already (shift + ctrl + e) or (File -> Export -> Export Audio...)
7. open the label text file
8. open this website: https://toolslick.com/conversion/subtitle/audacity-label-to-json
9. follow on-screen instructions to convert to JSON
10. send audio file and converted label file to KvaGram

NOTE:
If a line does not have any audio, or none is made, it **still** needs a label.
The tracks are played in order, so if a line is missing from the label list, it **will** play the next audio track, putting everything out of order.
So, to remedy this, just add a label of just silence in the correct order of it all. Don't need to be long. Half a secund might be good enough.
On that note, keep a secund or two between each line of dialouge, just for situations like this.

Don't want to bother with audacity? I don't know what to tell you.
At least send the audiofile to KvaGram. If you haven't applied a noise filter, please include some silence as well.