namespace :db do
  desc "<Drop>, create, migrate and repopulate with sample data"
  # task repopulate: [:drop, :create, :migrate, :fakeit] do
  task repopulate: [:migrate, :fakeit] do
    puts "REPOPULATION COMPLETED"
  end

  desc "Fill in dummy into tables"
  task fakeit: :environment do
    USERS_NUMBER = 6

    # Data
    acts = [
      { cat: 'Work',
        act: ['C#', 'Ruby', 'translations', 'design', '3d-modeling', 'SEO', 'photography']
      },
      { cat: 'Sport',
        act: ['fitness', 'bodybuilding', 'running', 'swimming', 'tennis', 'cycling', 'basketball']
      },
      { cat: 'Study',
        act: ['English language', 'German language', 'programming', 'drawing', 'driving', 'photography', 'cooking']
      },
      { cat: 'Bad habits',
        act: ['Internet surfing', 'TV Series', 'TV Shows', 'drinking', 'chats']
      }
    ]

    # Categories
    acts.length.times do |i|
      Category.create!(
        name: acts[i][:cat],
        desc: Faker::Matz.quote
      )
    end

    # Actions
    200.times do
      cat_i = rand(1..acts.length)
      names = acts[cat_i - 1][:act]
      Act.create!(
        date: Faker::Date.between(3.years.ago, 1.month.ago),
        name: names[rand(1..names.length) - 1],
        desc: Faker::Matz.quote,
        value: rand * (16 / acts.length),
        category_id: cat_i,
        user_id: rand(1..USERS_NUMBER)
      )
    end
  end

end
