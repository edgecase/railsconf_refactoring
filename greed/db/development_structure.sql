CREATE TABLE "computer_players" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "strategy" varchar(255), "score" integer DEFAULT 0, "game_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "faces" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "value" integer, "roll_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "games" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "human_players" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "score" integer, "game_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "rolls" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "score" integer, "unused" integer, "action" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "turns" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "game_id" integer, "player_id" integer, "score" integer, "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20090417195107');

INSERT INTO schema_migrations (version) VALUES ('20090417195145');

INSERT INTO schema_migrations (version) VALUES ('20090419032003');

INSERT INTO schema_migrations (version) VALUES ('20090428151959');

INSERT INTO schema_migrations (version) VALUES ('20090501194826');

INSERT INTO schema_migrations (version) VALUES ('20090501194952');