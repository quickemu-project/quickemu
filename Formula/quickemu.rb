class Quickemu < Formula
  desc "Quickly create and run optimised Windows, macOS and Linux virtual machines"
  homepage "https://github.com/quickemu-project/quickemu"
  url "https://github.com/quickemu-project/quickemu/archive/refs/tags/4.9.7.tar.gz"
  sha256 "38a93301a2b233bc458c62d1228d310a9c29c63c10d008c2905029ca66188606"
  license "MIT"

  depends_on "bash"
  depends_on "cdrtools"
  depends_on "coreutils"
  depends_on "jq"
  depends_on "python3"
  depends_on "qemu"
  depends_on "samba"
  depends_on "socat"
  depends_on "swtpm"
  depends_on "usbutils"
  depends_on "zsync"

  def install
    bin.install "quickemu"
    bin.install "quickget"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test quickemu`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    system "false"
  end
end
