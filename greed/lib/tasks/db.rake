namespace "greed" do
  task :kill_db do
    rm "db/development.sqlite3"
    rm "db/test.sqlite3"
  end

  task :rebuild => ["greed:kill_db", "db:migrate", "db:test:clone_structure"]
end
