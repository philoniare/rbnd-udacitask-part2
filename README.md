# Udacitask 2.0

## Project Overview

As projects get larger, and more complex, scalability and organization can become a challenge if it's not anticipated early on.
* **The Basics**: add, delete, and all methods are written and functional.
* **Errors**: `InvalidItemType`, `IndexExceedsListSize`, and `InvalidPriorityValue` are used appropriately.
* **Gems**: A **minimum of 3 gems** (you can use more!) are used in the project. `Gemfile` and `Gemfile.lock` are updated appropriately.
    * **Chronic**: Used the Chronic gem to parse dates such as “In 5 weeks”
    * **Colorize**: Used the Colorize gem to colorize the priority to-do symbols ⇩⇨⇧
    * **Colorize**: Used to interact with command line I/O
* **Additional features**:
    * Each item displays its item type along with the item description.
    * Wrote a method `list.filter(item_type)` that takes an `item_type` as input and returns only list items of that type if they exist, or alerts the user if there aren't any items of that type.
    * Added command-line I/O class for adding new items and creating new lists
    * Allow for the deletion of multiple items
