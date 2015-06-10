# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Blogposts" do
    describe "Admin" do
      describe "blogposts", type: :feature do

        refinery_login_with :refinery_user


        describe "blogposts list" do
          before do
            FactoryGirl.create(:blogpost, :title => "UniqueTitleOne")
            FactoryGirl.create(:blogpost, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.blogposts_admin_blogposts_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.blogposts_admin_blogposts_path

            click_link "Add New Blogpost"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              expect { click_button "Save" }.to change(Refinery::Blogposts::Blogpost, :count).from(0).to(1)

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
            end
          end

          context "invalid data" do
            it "should fail" do
              expect { click_button "Save" }.not_to change(Refinery::Blogposts::Blogpost, :count)

              expect(page).to have_content("Title can't be blank")
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:blogpost, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.blogposts_admin_blogposts_path

              click_link "Add New Blogpost"

              fill_in "Title", :with => "UniqueTitle"
              expect { click_button "Save" }.not_to change(Refinery::Blogposts::Blogpost, :count)

              expect(page).to have_content("There were problems")
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:blogpost, :title => "A title") }

          it "should succeed" do
            visit refinery.blogposts_admin_blogposts_path

            within ".actions" do
              click_link "Edit this blogpost"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            expect(page).to have_content("'A different title' was successfully updated.")
            expect(page).not_to have_content("A title")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:blogpost, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.blogposts_admin_blogposts_path

            click_link "Remove this blogpost forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Blogposts::Blogpost.count).to eq(0)
          end
        end

      end
    end
  end
end
