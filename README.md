This project demonstrates the design and implementation of a relational database system for a social media platform using MySQL.
It provides a structured schema for managing users, posts, comments, likes, and hashtags, along with various queries for retrieving and analyzing data effectively.

Key Features 
Database Design:
Tables include users, posts, comments, likes, hashtags, and post_hashtags with appropriate relationships and constraints.
Utilizes foreign keys to maintain data integrity across related tables.
User Management:
Stores unique user information such as usernames, emails, and join dates.
Content Management:
Supports posts with optional hashtags and associated metadata.
Facilitates user interactions via comments and likes.
Hashtag Tracking:
Tracks hashtags associated with posts for trend analysis and retrieval.

Data Analytics :
Retrieve user posts, comments, and likes.
Identify popular posts and hashtags based on engagement.
Perform date-based analysis, such as finding posts in specific time ranges or top-liked posts in the past 30 days.
Advanced metrics like user engagement scores and most commented hashtags.
User Access and Security
Example of user creation with restricted privileges:
User social_media_user is granted read and write access but restricted from inserting new records into the database.

Use Cases
Data Retrieval:
View all posts by a specific user or comments on a post.
List posts with no comments or the most active users.
Engagement Analysis:
Analyze the total likes and comments for posts.
Identify the most engaged users or trending hashtags.
Advanced Filtering:
Regex filtering for email domains and advanced user segmentation.

Sample Data
Users: 10 pre-defined users with unique usernames and emails.
Posts: Example posts with content and hashtags.
Comments and Likes: Simulated interactions for engagement analysis.
Database Creation
To create and populate the database, use the provided SQL script:

Create the database and tables.
Insert sample data into users, posts, comments, likes, and hashtags.
User Access Setup
A sample user with limited privileges can be created for secure access:
CREATE USER 'social_media_user'@'localhost' IDENTIFIED BY 'Complex@Password1';
GRANT ALL PRIVILEGES ON social_media_db.* TO 'social_media_user'@'localhost';
REVOKE INSERT ON social_media_db.* FROM 'social_media_user'@'localhost';

Queries Overview
Basic Data Retrieval:
Posts by a user.
Comments and likes on a post.
Engagement Analysis:
Top posts and hashtags by engagement.
Active users and user engagement scores.
Date-Based Analysis:
Filter posts by date ranges.
Identify trends in recent user activity.
Advanced Filtering:
Use of regular expressions for email validation and filtering.

License :
This project is open for learning and improvement. Feel free to use, modify, and contribute.

