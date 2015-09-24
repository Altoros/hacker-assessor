def body_json
  JSON.parse last_response.body, symbolize_names: true
end

def hacker
  Hacker.create name: 'Jorge'
end

def seniority
  Seniority.create name: 'Senior Frontend'
end

def skills
  Skill.create name: 'TDD', description: 'Cool description'
  Skill.create name: 'JavaScript', description: 'Cool description'
end

def acquirements_body
  { acquirements: [ { skill: '1' }, { skill: '2' } ] }.to_json
end

def requirements_body
  { requirements: [ { skill: '1' }, { skill: '2' } ] }.to_json
end

def seniority_body
  { seniority: { name: 'Senior Ruby' } }.to_json
end

def skill_body
  { skill: { name: 'Time Traveler',
             description: 'The best way to travel' } }.to_json
end

scope 'Login and Signup' do
  # TODO
end

scope '/hackers' do
  setup do
    hacker
  end

  test 'get a list of hackers' do |hacker|
    get '/hackers'
    assert_equal 200, last_response.status
    assert_equal hacker.name, body_json.first[:name]
  end

  test 'Create a list of Acquirements for a hacker and get the acquirements' do |hacker|
    skills
    post "/hackers/#{ hacker.id }/acquirements", acquirements_body
    assert_equal 201, last_response.status
    assert_equal 2, hacker.acquirements.count

    get "/hackers/#{ hacker.id }/acquirements"
    assert_equal 200, last_response.status
    assert_equal 'TDD', body_json.first[:name]
  end

  # TODO: Missing logic in the endpoint.
  # test 'Get a list of seniorities that a hacker can reach' do |hacker|
  #   get "/hackers/#{ hacker.id }/seniorities"
  # end

  # TODO: Missing logic in the endpoint.
  # test 'Return the skills that a hacker need to reach the next seniority' do |hacker|
  #   get "/hackers/#{ hacker.id }/seniorities/#{ seniority.id }"
  #   assert_equal 200, last_response.status
  #   assert_equal 'TDD', body_json.first[:name]
  # end
end

scope '/seniotities' do
  setup do
    seniority
  end

  test 'Get all the seniorities' do |seniority|
    get '/seniorities'
    assert_equal 200, last_response.status
    assert_equal seniority.name, body_json.first[:name]
  end

  test 'Create a seniority' do
    post '/seniorities', seniority_body
    seniority = Seniority.all
    assert_equal 201, last_response.status
    assert_equal 2, seniority.count
    assert_equal 'Senior Ruby', seniority.to_a[1].attributes[:name]
  end

  test 'Create a list of Requirements for a seniority and get the requirements' do |seniority|
    skills
    post "/seniorities/#{ seniority.id }/requirements", requirements_body
    assert_equal 201, last_response.status
    assert_equal 2, seniority.requirements.count

    get "/seniorities/#{ seniority.id }/requirements"
    assert_equal 200, last_response.status
    assert_equal 'TDD', body_json.first[:name]
  end
end

scope '/skills' do
  setup do
    skills
  end

  test 'Get all the skills' do |skills|
    get '/skills'
    assert_equal 200, last_response.status
    assert_equal Skill.all.count, body_json.count
  end

  test 'Create a new skill' do
    post '/skills', skill_body
    skills = Skill.all
    assert_equal 201, last_response.status
    assert_equal 3, skills.count
    assert_equal 'Time Traveler', skills.to_a[2].attributes[:name]

  end

  test 'Get a single skill' do |skill|
    get "/skills/#{ skill.id }"
    assert_equal 200, last_response.status
    assert_equal skill.name, body_json[:name]
  end
end