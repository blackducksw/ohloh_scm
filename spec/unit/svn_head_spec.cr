require "../test_helper"

describe "SvnHead" do

  it "head_and_parents" do
    with_svn_repository("svn") do |svn|
      assert_equal 5, svn.head_token
      assert_equal 5, svn.head.token
      assert svn.head.diffs.any?

      assert_equal 4, svn.parents(svn.head).first.token
      assert svn.parents(svn.head).first.diffs.any?
    end
  end

  it "parents_encoding" do
    with_invalid_encoded_svn_repository do |svn|
      assert_nothing_raised do
        commit = Struct.new(:token).new(:anything)
        svn.parents(commit) rescue raise Exception
      end
    end
  end
end
end
