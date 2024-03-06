
curl -o linux.tar.gz -L https://git.kernel.org/torvalds/t/linux-6.8-rc7.tar.gz
tar xzf linux.tar.gz
cd linux-*
make allnoconfig rust.config
./scripts/config --disable GCC_PLUGINS
./scripts/config --disable RANDSTRUCT
#./scripts/config --disable CONFIG_HAVE_GCC_PLUGINS
./scripts/config --enable RUST
./scripts/config --enable HAVE_RUST
cat .config | grep "RUST"
make rustavailable
make rustdocs
cat .config | grep "RUST"
