![Recipes1README1](https://github.com/user-attachments/assets/cdf1cb9c-9626-4197-825e-de9d710757be)

https://github.com/user-attachments/assets/71d970c7-fa70-4b76-a327-39ac25309528

### Steps to Run the App
* Clone the repository:
  ```
  git clone https://github.com/bwondessen/Recipes.git
  ```
* Double-click on the .xcodeproj file in the project folder to open it in Xcode
* Select a Simulator
* Build and run the Project

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I prioritized efficiency, architecture, and the UI/UX of the app. 

One of the most important aspects of software development is ensuring that data is processed correctly and quickly. A fast and smooth app greatly enhances the user's experience.

Having a clean and organized architecture is imperative because it allows the app to scale. A clear separation of concerns also makes unit testing much easier, further increasing scalability. This approach results in more organized and readable code, which is crucial when working in a team environment.

UI/UX is critical to the success of any app. A poorly designed interface can be a dealbreaker for many users. Accessibility is always at the forefront of my design decisions. For example, I made the app as intuitive and user-friendly as possible by offering users different ways to perform tasks, such as:
  * Providing filtering by categories.
  * Allowing users to refresh data either by tapping a button or pulling down on the screen.
  * Ensuring compatibility with both dark and light modes. 

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I worked on this app for approximately 5–6 hours in total. I spent about 2 hours per day during my free time over the past few days.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
One trade-off I encountered was choosing the appropriate data persistence solution.

I considered using Core Data or SwiftData, but I ultimately decided on UserDefaults because the data I needed to save (a single boolean for the preferred color scheme) required minimal storage. UserDefaults was the perfect fit for this task, as using Core Data or SwiftData would have been inefficient since they are larger, more powerful frameworks that would not have been fully utilized for this simple requirement.

### Weakest Part of the Project: What do you think is the weakest part of your project?
I would say the weakest part of my project is the testing. While it checks for the most critical cases, I could have included tests for more obscure edge cases.
