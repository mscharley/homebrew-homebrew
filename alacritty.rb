# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Alacritty < Formula
  desc "A cross-platform, GPU-accelerated terminal emulator"
  homepage "https://github.com/jwilm/alacritty"
  url "git@github.com:jwilm/alacritty.git",
    :using => :git,
    :revision => "715d4f8be8b80604a0b6a8464e55a60660f810a0"
  version "master"
  revision 0
  # sha256 ""

  depends_on "cmake" => :build
  depends_on "rust" => :build
  depends_on "fontconfig"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    system "cargo", "build", "--release"
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
