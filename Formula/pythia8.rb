# taken from https://github.com/davidchall/homebrew-hep/blob/master/Formula/pythia.rb
class Pythia8 < Formula
  desc "Monte Carlo event generator"
  homepage "https://pythia.org/"
  url "https://pythia.org/download/pythia82/pythia8243.tgz"
  version "8.243"
  sha256 "067219fb737bfd379ddb602b609ff5cd04f0569782f8d9d59e403264fd8a21f3"

  bottle do
    root_url "https://github.com/acts-project/homebrew-tap/releases/download/pythia8-8.243"
    sha256 catalina:     "f388a79a6d6505eb9e6c650c490380f77ae7e6337a3b767f8cba75073a4d2894"
    sha256 x86_64_linux: "d3e604cb89762db6b5a70e736a549e0ac753b9d0aa43d607f8ed54de9286d844"
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-shared
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "true"
  end
end
