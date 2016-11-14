# Morning Breath, the Daily Morning App

An app that makes the start of your day much simpler. 

##Features
- Weather 
- Top 10 news feed from Washington Post 
- Motivational Quote 
- MTA Advisories
- New background daily
- And Brit Siri reads that all aloud to you, BBC News style! 

##Future Roadmap: 
- implementing an alarm that activates Siri 
- filter setting to users content (like Facestergram) 

#Lessons Learned

##Karen

###The Importance of API documentation! 

After some long contemplation, you finally have an idea and if you’re lucky you found the API that’ll make your App possible. If you’re like me, you look at the JSON data, and you’re ready to dive in and start your parsing.  


For the Morning Breath team I was in charge of the weather API from the open weather map and the inspirational quote of the day. While the quote API was pretty straightforward to parse, the weather was a little more difficult due to the weather temperature returning in Kelvin. 


I decided to write a class function like so: 


```swift
static func convertKelvin(toFahrenheit scale: Bool = true, kelvin: Int) -> Int {

	if scale {
		return Int((Double(kelvin) - 273.15) * 9/5 + 32)
	}
	else {
		return Int(Double(kelvin) - 273.15)
	}
}
```

the convertToKelvin function could have been avoided if I read the documentation more closely. The documentation states that when you put Fahrenheit as one of your keys  in the call your return will have temperature as a Fahrenheit.  Thus read documentation it can save you some time, work, and maybe some frustration. 

### DATE FORMATTER 

I was curious as to how to make our Morning Breath App show a date format of Month, Day, Year. 


I implemented the following method with in our view controller:

```swift 
func makingDate(){
	let dateformatter = DateFormatter()
	dateformatter.dateFormat = "MMMM dd, yyyy"

	dateLabel.text = dateformatter.string(from: Date())
}
```

The method makingDate has an instantiation of the DateFormatter class that has a property of DateFormat which  is an enumeration of different styles of Dates. A set the style of date I wanted and set the date label’s text to that string. 

### Launch Screen, App Icon, and Animation

Once Most of our app was completed, I noticed that our app was taking some time to load. I decided to delve into the launch screen. 


At first I was going to do an animation while the data loaded in the background. As I went through a series of Stack Overflow posts and many other google searches I learned that you can’t really animate on the launch Screen itself with in the main story board. 


What you can do is duplicate it (LaunchScreen) in storyboard and make it as entrance View controller of your app. Then when view gets loaded - start your animation. As a final result you will have "animating splash screen": App starts -> static launch screen -> transition to entrance view controller  which won't be visible by user because scenes look the same .  This Something I am still working on as Animation is something out of the scope of what I’ve learned so far.  For now are morning breath app has an image in the launch screen that as Thinley stated : “looks like a 20th century fox film poster”


Creating an app Icon was something I was interested in making too. So I created our image and shortly figured out that I needed to make an image for each type of simulator Icon size.  making an icon for each of the sizes seemed a lot of work so I found this website: https://makeappicon.com   that gives you a zip file for each of the app Icon sizes. 


## Thinley


###Using Multiple APIs in One Project and the Flow of Building World-class App 

The project taught me how to use all the bits and pieces of Swift that I have been learning in past three months. The product I see from this three days project gives me confidence that I can build even more sophisticated Apps in the future. One of the most important lessons I have learned from the project is to master the challenge of juggling multiple APIs. We displayed information from four different APIs and beautifully squeezed them into one screen. The project also help me in building a fairly complicated App while making it easy to use. We would have use multiple screens for each APIs but we chose to be efficient and user-friendly. 


On top of that, I learnt some of the simple yet elegant features such as **NSDate Object**, **webView**, **manipulating API’s parameter**, **segue to designated website** and **AVSpeechSynthesizer Object** that reads text. 

## Vic


### Unforeseen consequences + Mismanaged Expectations = Powder Keg
I’ve had the luxury of ~~being forced into~~ working in collaborative efforts before, so I thought I’ve seen it all. Sometimes, it takes a keen managerial and technical eye to distill problems into lessons. Here are pitfalls I’ve encountered and ways I’ve dealt with them. 


1. When something goes wrong despite it working all other times before:
  * Find Jason.


2. When something seems like it’s about to go wrong:
  * Find Jason.


3. When someone else has detailed an answer on Stack but it’s in Objective C:
  * Find Jason.


4. If and when all else fails:
  * Find Louis.


#### Git, you git
I think a few of us might’ve had our projects eaten by `git fetch`ing a little too soon, but I didn’t think it’d be so testy to work with. After being burnt by the umpteenth `merge conflict`s, I have a few pro-tips for the inexperienced user that no one should never, ever follow.


1. `git fetch` is an angry god. Do not forget to pray every time you push to your branch, lest the next fetch fail due to `header` errors or storyboard merge fails.


2. It’s best to work on and add one file at a time to minimize overlap and thus merge failures. 
  * One can _reset_ accidental `git add .`s with `git reset`. Do it right or do it twice.


3. `git fetch` doesn’t seem to delete your contributions during conflicts. Make sure you don’t accidentally delete the wrong code around `HEAD` errors.


4. In case you have decided to do a pull request despite merge warnings because ~~there doesn’t seem to be an alternative~~ ~~deleting commits are a bit too dangerous~~ one must always move forward, then following the 6 steps listed in the pull request tab should work.
  1. Unless it’s a storyboard. Then you’ve probably corrupted that file in your *develop* branch and now no one can open it. Good going.
  2. You could probably fix it if you copied and pasted your entire project folder elsewhere before `git commit`ing. You have, right? Just paste and replace that corrupted storyboard that everyone fetched with your backed up copy.
  3. You didn’t save one, did you?
  4. Do it right or do it twice.


#### Looking busy
What happens once you’ve gone through most of your features list for your project, but every other team, sitting far away, is gesticulating wildly or have their heads down in their hands? It’s only Wednesday, but you’re pretty much done after judicial use of Jason. So what do you do? Here’s a checklist, in no particular order:


* Pat yourself on the back. You’ve done well managing yourself and quite possibly your team. You’ve had a thought-out project plan, you’ve delegated and delivered the work accordingly, and god’s in his heaven, all’s right with the world.


* _Keep it simple_, they told you, but maybe this project was a bit too simple. Maybe just this once, feature creep will be a good thing. Start brainstorming-- again-- and see if you can make your project a bit more snazzy.


* Debug. Because all these new ideas are breaking your code.


* Streamline your layout. You might as well, since all these new elements already broke autolayout anyway.


* Realize you have big dreams for your baby and that you’re never going to be able to achieve them all within a week.


### AVSpeechSynthesizer


At first, making Siri talk is super cool to you and every other table next to you. Nothing can rouse delight in a fellow student like making Siri say dirty words. Eventually though, it gets old, and you have to move on with some actual work. So when you’re putting foul language in your iDevice’s mouth, this is what you should know about *AVSpeechSynthesizer*:


* Siri is a dude if you speak her to British English with the `AVSpeechSynthesisVoice`. Don’t be surprised. 


* There is a difference between `speakSpeaking()` and `pauseSpeaking()`. Mainly, you can continue off with the latter, but you can’t just get her to `speak()` the same _utterance_ again. If you made Siri pause, you must tell her to `continueSpeaking()`.


```swift
if isStopped {
	synthesizer.speak(myUtterance)
	isPaused = false
} else {
	synthesizer.stopSpeaking(at: .immediate)
	isPaused = true
}
```
The above will make Siri start over from the beginning if you make her `speak()` again.


```swift
if isPaused {
	synthesizer.continueSpeaking(myUtterance)
	isPaused = false
} else {
	synthesizer.pauseSpeaking(at: .immediate)
	isPaused = true
}
```
This will continue where Siri left off whence you paused her.
