require "../spec_helper"

describe "SvnChainCatFile" do

  it "cat_file_with_chaining" do
goodbye = <<-EXPECTED
#include <stdio.h>
main()
{
	printf("Goodbye, world!\\n");
}

EXPECTED
    with_svn_chain_repository("svn_with_branching", "/trunk") do |svn|
      # The first case asks for the file on the HEAD, so it should easily be found
      svn.cat_file(OhlohScm::Commit.new(token: "8"), OhlohScm::Diff.new(path: "goodbyeworld.c")).should eq(goodbye)

      # The next test asks for the file as it appeared before /branches/development was moved to /trunk,
      # so this request requires traversal up the chain to the parent SvnAdapter.
      svn.cat_file(OhlohScm::Commit.new(token: "5"), OhlohScm::Diff.new(path: "goodbyeworld.c")).should eq(goodbye)
    end
  end
end
