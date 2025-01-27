# FredsRecipes
Fred Strout's submission of the Fetch recipes new candidate exercise.
### Summary: Include screen shots or a video of your app highlighting its features
I decided to organize my recipes by cuisine. Every cuisine has its own section that displays a horizontally scrolling list of the recipes that belong to it. Each recipe is displayed on a tile that contains its name, an image, a button to open the source url if there is one and a button to open the youtube channel if there is one. Tapping on the image opens a sheet view containing the same data in a different format.
[![Fetch Recipes by Fred](https://img.youtube.com/vi/MfA1LUeHSy8/maxresdefault.jpg)](https://youtu.be/MfA1LUeHSy8)

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I can't say I prioritized any part over another. I started on the UI. I then moved on to the api integration and finished up with the unit tests. The detail sheet view was added after the first submission; it didn't feel right calling this project finished without that view.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent about ~~14~~ 18-20 hours on this project. I did the bulk of the ui work on Thursday afternoon following my interview with Katie: I integrated the API on Friday morning, followed by writing the Unit Tests on Monday. I added the detail view on Monday, January 27th (4 hours).

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I originally had the unit tests in one file, but I really didn't like how that was origanized. This second go around I moved them to their own files and stored them next to the objects they test. I think this is more better :wink:.

It also would have been nice to setup string localization; it was pretty weird seeing string literals in the views and viewModels. It also would have given me the opportuniy to explore String Catalogs.

### Weakest Part of the Project: What do you think is the weakest part of your project?
I used the new Swift Testing package to test the app. I'm not very familar with it. In fact, this was my first opportunity to play around with it. I'm pretty certain had I used XCTest I could have knocked this out a lot faster.


### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I originally created this project for the Staff iOS Software Engineer position. I made some updates before re-submitted it for the iOS Software Engineer's position.

* Added the RecipeDetailView
* Re-organized the file structure
* Added some protocols so I could more thoroughly test the viewModels.
