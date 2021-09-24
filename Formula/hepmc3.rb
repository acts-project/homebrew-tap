# taken from https://github.com/davidchall/homebrew-hep/blob/master/Formula/hepmc3.rb
class Hepmc3 < Formula
  desc "Library is to handle  event record for Monte Carlo generators"
  homepage "https://hepmc.web.cern.ch/hepmc/"
  url "https://hepmc.web.cern.ch/hepmc/releases/HepMC3-3.2.2.tar.gz"
  sha256 "0e8cb4f78f804e38f7d29875db66f65e4c77896749d723548cc70fb7965e2d41"

  bottle do
    root_url "https://github.com/acts-project/homebrew-tap/releases/download/hepmc3-3.2.2"
    sha256                               catalina:     "900c856fc3ea469e2577d36fcae15e38e9e3be465ecf02318e80dcfb0e31ac8f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "09914df83c39f7a4605f397c4bae55ba0218106355a7b25c36d727d8b87df023"
  end

  option "with-test", "Test during installation"
  option "with-python", "Enable building of python bindings"
  option "with-root", "Enable root IO"

  depends_on "cmake" => :build
  depends_on "python" => :optional
  depends_on "root" => :optional

  def install
    mkdir "../build" do
      args = %W[
        -DCMAKE_INSTALL_PREFIX=#{prefix}
        -DHEPMC3_INSTALL_INTERFACES=ON
      ]
      args<<"-DHEPMC3_ENABLE_TEST=ON" if build.with? "test"
      args<<"-DHEPMC3_ENABLE_PYTHON=OFF" if build.without? "python"
      args<<"-DHEPMC3_ENABLE_ROOTIO=OFF" if build.without? "root"
      system "cmake", buildpath, *args
      system "make"
      system "make", "test" if build.with? "test"
      system "make", "install"
    end
  end

  test do
    system "true"
  end
end
