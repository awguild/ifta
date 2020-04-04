describe 'Authentication' do
  before {
    create_conference
  }

  it 'should be able to get the homepage when logged out' do
    get "/"
    expect(response.status).to eql(200)
  end

  it 'should not be able to get authenticated page when not signed in' do
    get '/users/edit'
    expect(response.status).to eql(302)
  end

  it 'should be able to get authenticated page when signed in' do
    sign_in_as_a_valid_user
    follow_redirect!
    get '/users/edit'
    expect(response.status).to eql(200)
  end

  it 'should not be able to get an admin page as a regular user' do
    sign_in_as_a_valid_user
    follow_redirect!
    conference = Conference.first
    expect {
      get "/conferences/#{conference.conference_year}"
    }.to raise_error(CanCan::AccessDenied)
  end

  it 'should allow the admin to get to the admin page' do
    sign_in_as_a_admin_user
    follow_redirect!
    conference = Conference.first
    get "/conferences/#{conference.conference_year}"
    expect(response.status).to eql(200)
  end

end
