set -e

curl -o linux.tar.gz -L https://git.kernel.org/torvalds/t/linux-6.8-rc7.tar.gz
tar xzf linux.tar.gz
cd linux-*
make allnoconfig rust.config defconfig
#./scripts/config --enable GCC_PLUGINS
./scripts/config --disable RANDSTRUCT
./scripts/config --disable MODVERSIONS
./scripts/config --disable RANDSTRUCT
./scripts/config --disable DEBUG_INFO_BTF
./scripts/config --enable RUST
./scripts/config --enable HAVE_RUST
./scripts/config --enable CONFIG_RUST
./scripts/config --enable CONFIG_HAVE_RUST
./scripts/config --enable CONFIG_RUST_OVERFLOW_CHECKS

cat .config | grep "RUST"
make rustavailable
cat .config
make prepare
cat .config | grep "RUST"
make rustdoc
cat .config | grep "RUST"
