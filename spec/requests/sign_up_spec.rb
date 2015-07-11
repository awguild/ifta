require 'spec_helper'

describe 'SignUp' do
  before { create_conference }

  it 'should redirect to the edit user page after sign up then itineraries page' do
    ApplicationController.any_instance.stubs(:verify_recaptcha).returns(true)

    ##################
    # Sign Up Page
    ##################
    post '/users', { user: {
      email: 'test123@example.com',
      password: 'password',
      password_confirmation: 'password'
    }}

    expect(response.status).to eql(302)
    follow_redirect! # after sign in path itineraries page
    follow_redirect! # check_contact_info before filter

    ##################
    # Contact Info Page
    ##################
    expect(response).to render_template('users/edit')

    user = assigns(:user)
    country = FactoryGirl.create(:country)
    put "/users/#{user.id}", { user: {
      first_name: 'Jane',
      last_name: 'Doe',
      nametag_name: 'Jane Doe',
      certificate_name: 'Jane Doe',
      country_id: country.id,
      state: 'IL',
      city: 'Rock Island',
      zip: '60510',
      phone: '1112223333',
      fax_number: '4445556666',
      email: 'jdoe@example.com',
      student: 0,
      member: 0,
      emergency_name: 'John Doe',
      emergency_relationship: 'Father',
      emergency_telephone: '1112223333',
      emergency_email: 'jdoe@example.com'
    }}

    expect(response.status).to eql(302)
    follow_redirect!

    ##################
    # Itineraries page
    ##################
    expect(response).to render_template('itineraries/edit')

  end
end