# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class AwsEsProxy < Formula
  desc "aws-es-proxy is a small web server application sitting between your HTTP client (browser, curl, etc...) and Amazon Elasticsearch service."
  homepage "https://github.com/abutaha/aws-es-proxy"
  version "0.4"
  # revision 0
  url "https://github.com/abutaha/aws-es-proxy/releases/download/v0.4/aws-es-proxy-0.4-mac-amd64"
  sha256 "283fb86e6d2b296bbacb0fdb78779176ea97f4df2bf8baa66aff94de9edf5c1d"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    mv "aws-es-proxy-0.4-mac-amd64", "aws-es-proxy"
    system "chmod a+x aws-es-proxy"
    bin.install "aws-es-proxy"
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
