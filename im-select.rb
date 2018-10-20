# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class ImSelect < Formula
  desc "Switch your input method from terminal"
  homepage "https://github.com/daipeihust/im-select"
  head "https://github.com/daipeihust/im-select.git", using: :git
  # version ""
  # url ""
  # revision 0
  # sha256 ""

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Grab the bits we care about.
    bin.install "im-select-mac/out/im-select"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test alacritty`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
