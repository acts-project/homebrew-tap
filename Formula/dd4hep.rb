class Dd4hep < Formula
  desc "Detector Description Toolkit for High Energy Physics"
  homepage "http://dd4hep.cern.ch"
  url "https://github.com/AIDASoft/DD4hep/archive/refs/tags/v01-17.tar.gz"
  version "01-17"
  sha256 "036a9908aaf1e13eaf5f2f43b6f5f4a8bdda8183ddc5befa77a4448dbb485826"
  license "NOASSERTION"

  depends_on "cmake" => :build
  depends_on "geant4"
  depends_on "python"
  depends_on "root"
  depends_on "xerces-c"
  uses_from_macos "expat"
  uses_from_macos "zlib"

  patch :p1, :DATA

  def install
    system "cmake",
           "-S",
           ".",
           "-B",
           "build",
          "-DCMAKE_BUILD_TYPE=Release",
          "-DDD4HEP_USE_GEANT4=ON",
          "-DDD4HEP_IGNORE_GEANT4_TLS=ON",
          "-DCMAKE_CXX_STANDARD=17",
          "-DBUILD_DOCS=OFF",
           *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "true"
  end
end
__END__
diff --git a/cmake/DD4hepBuild.cmake b/cmake/DD4hepBuild.cmake
index 6a2ddde..148c16a 100644
--- a/cmake/DD4hepBuild.cmake
+++ b/cmake/DD4hepBuild.cmake
@@ -684,7 +684,7 @@ macro(DD4HEP_SETUP_ROOT_TARGETS)
     ENDIF()
     dd4hep_debug("D++> Python version used for building ROOT ${ROOT_PYTHON_VERSION}" )
     dd4hep_debug("D++> Required python version ${REQUIRE_PYTHON_VERSION}")
-    FIND_PACKAGE(Python ${REQUIRE_PYTHON_VERSION} EXACT REQUIRED COMPONENTS Development)
+    FIND_PACKAGE(Python ${REQUIRE_PYTHON_VERSION} REQUIRED COMPONENTS Development)
   ELSE()
     FIND_PACKAGE(Python COMPONENTS Development)
   ENDIF()
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -135,6 +135,7 @@ if(DD4HEP_USE_GEANT4)
   IF(NOT Geant4_builtin_clhep_FOUND)
     SET(DD4HEP_USE_CLHEP TRUE)
   ENDIF()
+  message(STATUS ${Geant4_TLS_MODEL})
   DD4HEP_SETUP_GEANT4_TARGETS()
   # Geant4 sets the CLHEP include directory to include_directories, we undo this here
   # we don't do this inside DD4hep_SETUP_GEANT4_TARGETS, because that is also used in
