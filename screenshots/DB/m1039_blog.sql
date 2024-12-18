CREATE TABLE `comments` (
  `comment_id` int NOT NULL,
  `tweet_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `content` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `follows` (
  `follower_id` int NOT NULL,
  `following_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `likes` (
  `user_id` int NOT NULL,
  `tweet_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tweets` (
  `tweet_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `content` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_pic` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default_profile.jpg',
  `bio` mediumtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `tweet_id` (`tweet_id`),
  ADD KEY `user_id` (`user_id`);

ALTER TABLE `follows`
  ADD PRIMARY KEY (`follower_id`,`following_id`),
  ADD KEY `following_id` (`following_id`);

ALTER TABLE `likes`
  ADD PRIMARY KEY (`user_id`,`tweet_id`),
  ADD KEY `tweet_id` (`tweet_id`);

ALTER TABLE `tweets`
  ADD PRIMARY KEY (`tweet_id`),
  ADD KEY `user_id` (`user_id`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

ALTER TABLE `comments`
  MODIFY `comment_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `tweets`
  MODIFY `tweet_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT;

ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`tweet_id`) REFERENCES `tweets` (`tweet_id`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `follows`
  ADD CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`follower_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`following_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`tweet_id`) REFERENCES `tweets` (`tweet_id`);

ALTER TABLE `tweets`
  ADD CONSTRAINT `tweets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
