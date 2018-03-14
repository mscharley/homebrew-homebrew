# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
class Alacritty < Formula
  desc "A cross-platform, GPU-accelerated terminal emulator"
  homepage "https://github.com/jwilm/alacritty"
  head "https://github.com/jwilm/alacritty.git", using: :git
  # version "0.1.0"
  # revision 0
  # sha256 ""

  depends_on "cmake" => :build
  depends_on "fontconfig"

  option "with-cache", "Use a cargo cache in /usr/local/var/cache during the build."

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    if build.without? "cache"
      # Setup some temporary working folders to download tools into.
      ENV["CARGO_HOME"] = buildpath/"opt/cargo"
      ENV["RUSTUP_HOME"] = buildpath/"opt/rustup"
    else
      ENV["CARGO_HOME"] = "/usr/local/var/cache/cargo"
      ENV["RUSTUP_HOME"] = "/usr/local/var/cache/rustup"
    end

    # Install a stable Rust installation.
    system 'curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path'
    if build.without? "cache"
      ENV.append_path "PATH", *Dir[buildpath/"opt/rustup/toolchains/*/bin/"]
    else
      ENV.append_path "PATH", *Dir["/usr/local/var/cache/rustup/toolchains/*/bin/"]
    end

    # Build the app!
    system "make", "app"

    # Grab the bits we care about.
    (prefix / "Applications").install "target/release/osx/Alacritty.app"
    bin.install "target/release/alacritty"
    (share / "alacritty").install *Dir["alacritty*.yml"]
  end

  def caveats
    msg = <<~EOS
      Although it is possible that the default configuration will work on your
      system, you will probably end up wanting to customize it anyhow. You can
      find a copy of the default configuration at:

        /usr/local/share/alacritty/alacritty_macos.yml

      You can copy this file to ~/.alacritty.yml and edit as you please.

      WARNING: This formula can't install into /Applications, the application
      has been installed to:

        #{prefix / "Applications/Alacritty.app"}

      This path is stable across upgrades, you can create your own symlink in
      the global /Applications folder as follows:

        ln -s #{prefix / "Applications/Alacritty.app"} /Applications/
    EOS

    if build.with? "cache"
      msg += <<~EOS

        This formula uses a cache in /usr/local/var/cache if you want to clear it.
      EOS
    end

    msg
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
