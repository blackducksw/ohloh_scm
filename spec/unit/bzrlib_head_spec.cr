require "../test_helper"

describe "BzrBzrlibHead" do

  it "head_and_parents" do
    with_bzrlib_repository("bzr") do |bzr|
      assert_equal "test@example.com-20111222183733-y91if5npo3pe8ifs", bzr.head_token
      assert_equal "test@example.com-20111222183733-y91if5npo3pe8ifs", bzr.head.token
      assert bzr.head.diffs.any? # diffs should be populated

      assert_equal "obnox@samba.org-20090204004942-73rnw0izen42f154", bzr.parents(bzr.head).first.token
      assert bzr.parents(bzr.head).first.diffs.any?
    end
  end

end
