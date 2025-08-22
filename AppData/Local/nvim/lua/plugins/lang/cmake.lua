return {
  "Civitasv/cmake-tools.nvim",
  opts = {
    cmake_generate_options = {
      "-G Ninja",
      "-DCMAKE_C_COMPILER=clang",
      "-DCMAKE_CXX_COMPILER=clang++",
      "-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
    },
  },
}
