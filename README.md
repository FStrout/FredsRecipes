# FredsRecipes
Fred Strout's submission of the Fetch recipes new candidate exercise.
### Summary: Include screen shots or a video of your app highlighting its features
I decided to organize my recipes by cuisine. I created a vertically scrolling list sectioned by cuisine and then created a horizontally scrolling list of the recipes associated with that cuisine. I also included a convenient way to redirect the endpoint to the empty and malformed URLs, although that required adding a little extra unnecessary code.

[![Watch the video](https://img.youtube.com/vi/Q4IpL2gt3n0/maxresdefault.jpg)](https://youtu.be/Q4IpL2gt3n0)

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I can't say I prioritized any part over another. I started on the UI, mostly since that's what I had to do it my last job since we would usually build out the ui using mocks before the backend was ready to be consumed.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent about 14 hours on this project. I did the bulk of the ui work on Thursday afternoon following my interview. I integrated the API on Friday morning. I then spent Monday writing the Tests, most of it spent wrestling with the APIServiceTests issue I talk about next.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I would have liked to have implemented a more robust mocking strategy. Testing is very important especially when it comes to network requests. I didn't get as far along as I would've liked because I kept running into issues with Swift Testing. Everything worked fine when running the tests from the FredsRecipeTests test file, but, when running all the tests from the Test Navigator, the APIServiceTests would step on each other.

### Weakest Part of the Project: What do you think is the weakest part of your project?
Had I implemented a better mocking strategy I would have been able to better test the APIService and the loadContent method of the RecipeListViewModel.


### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I started to create a main page that would allow the user to select what endpoint they wanted to see in the app, but I removed it because the instructions sounded pretty clear about only having a single view app. I also was going to create a detail view to display the information differently and I actually almost created a halh sheet detail view as a work around, but I didn't because I didn't want to upset the judges.
