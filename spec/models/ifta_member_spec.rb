require 'spec_helper'

# this outer block indicates that we're testing the IftaMember class
# we want to test both the class api and the instances api
# the instance api can include testing things like whether the association methods work and whether callbacks/validations are properly triggered
# the class api is basically the methods defined with self 
# private methods shouldn't be directly tested because they can't be called externally, but they shouldn't be stubbed out in your tests either otherwise you're not really testing the method
describe IftaMember do
  # let defines a memoized helper method 
  # Note: memoized means after you call it once it will just return a reference to its return value in all subsequent calls, aka it won't execute the method body again
  # the parameter inside of let (:ifta_member) will be the name of the helper method, you can use that method (ifta_member) anywhere in this describe block
  # { FactoryGirl.build(:ifta_member) } is a proc that essentially opperates as the body of the function (let adds the memoization). In this case it will return an instance of the IftaMember class (as defined in our :ifta_member factory)
  # the factory_girl_rails gem makes the FactoryGirl class avaialbe in the rspec tests
  # the build method will instantiate a new IftaMember object but not save it to the test database
  # the parameter to build (:ifta_member) is how FactoryGirl looks up what object to build
  # inside of the spec/factories/ifta_members file we defined a factory with the symbol :ifta_member
  let(:ifta_member) { FactoryGirl.build(:ifta_member)}


  describe "testing association with user" do
    #TODO
    pending
  end

  describe "testing uniquness validation" do
    #TODO
    pending
  end

  describe "testing IftaMember#add_new_members" do
        it "should increase the number of members by 1" do
            # expect can take a Proc { code } (think function) which it will call in a series of steps
            # for this example the change matcher will do the following
            # first it will call the change proc { IftaMember.count }
            # second it will call the expect proc { IftaMember.add_new_members ... }
            # third it will call the change proc again { IftaMember.count }
            # fourth it will compare the outputs and the two change procs, and make sure that count changed by whatever parmeter you passed it (1)
            expect { IftaMember.add_new_members('jdoe@example.com') }.to change{IftaMember.count}.by(1)
        end

        it "should increase the number of members by 2" do
            # using from and to parameters the change matcher can require more exact conditions than offered using by
            expect { IftaMember.add_new_members('jdoe@example.com, mdoe@example.com') }.to change{IftaMember.count}.from(0).to(2)
        end

        it "should not create a ifta_member with a duplicate email address" do
            # we've already tested that a record won't save with uniqueness validation errors
            # but we should treat the api for this object is like a black box 
            # the add_new_members method might do something to skip the validation callbacks
            # so we'll test to make sure that this method doesn't create records with duplicate email addresses 
            expect { IftaMember.add_new_members('jdoe@example.com, jdoe@example.com') }.to change{IftaMember.count}.by(1)
        end
   end

  describe "IftaMember#replace_all_members_with" do
      # use context blocks to wrap a series of tests that occur under the same state
      # this first group of tests is for when there is an existing member that should be removed
      context "when a member should be removed" do
        before {
            ifta_member.save!
            IftaMember.count.should == 1
        }

        it "should have 2 ifta members" do
            IftaMember.replace_all_members_with('mdoe@example.com, ndoe@example.com')
            expect(IftaMember.count).to eq(2)
        end

        it "should remove the old ifta members" do
            IftaMember.replace_all_members_with('mdoe@example.com')
            expect(IftaMember.all).not_to include(ifta_member)
        end

        it "should be able to re-add an email address it removed" do
            IftaMember.replace_all_members_with(ifta_member.email)
            expect(IftaMember.where(email: ifta_member.email).count).to eq(1)
        end
      end

      # this second group of tests is for when nobody is in the database
      context "when nobody is in the database" do
        it "should have 1 ifta member" do
            IftaMember.replace_all_members_with('mdoe@example.com')
            expect(IftaMember.count).to eq(1)
        end
      end
  end
end
