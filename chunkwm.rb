# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Chunkwm < Formula
  desc "Tiling window manager for MacOS based on plugin architecture"
  homepage "https://github.com/koekeishiya/chunkwm"
  head "git@github.com:koekeishiya/chunkwm.git", using: :git
  version "0.0.36"
  url "https://github.com/koekeishiya/chunkwm/archive/0.0.36.tar.gz"
  sha256 "cc732611ae96287829ac8220529383dbfccee245a861603e13612358cb67420d"
  # revision 0

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    ohai 'Making chunkwm.'
    system 'make', 'install'
    bin.install 'bin/chunkwm'

    ohai 'Making chunkc.'
    Dir.chdir 'src/chunkc' do
      system 'make'
      bin.install 'bin/chunkc'
    end

    ohai 'Making plugins.'
    Dir['src/plugins/*'].each do |plugin|
      Dir.chdir plugin do
        system 'make', 'install'
      end
    end

    system 'sed -ie "s!~/.chunkwm_plugins!/usr/local/lib/chunkwm/plugins!" examples/chunkwmrc'
    (lib / 'chunkwm').install 'plugins'
    (share / 'chunkwm').install 'docs'
    (share / 'chunkwm').install 'examples'
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
