# based on stuff I found:
# https://github.com/voc/voctomix/tree/voctomix2/voctocore#141-debian--ubuntu
# https://github.com/voc/voctomix?tab=readme-ov-file#developer-setup

sudo apt install \
    python3 \
    python3-gi \
    gir1.2-gstreamer-1.0 \
    gir1.2-gst-plugins-base-1.0 \
    libgstreamer1.0-0 \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    gstreamer1.0-vaapi \
    python3-sdnotify \
    python3-pyinotify \
    python3-scipy \
    rlwrap \
    fbset \
    ffmpeg \
    netcat-traditional

sudo apt install \
    build-essential \
    python3-dev \
    pkg-config \
    cmake \
    libcairo2-dev \
    libgirepository-2.0-dev


sudo apt build-dep voctomix


# install vu:

# https://debian.griffo.io/install-latest-uv-in-debian.html

curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
sudo apt update
sudo apt install uv

# uv pipx
sudo apt install pipx

# add ~/.local/bin to PATH in .bashrc
pipx ensurepath
# add to current shell
source ~/.bashrc

# tab completions?
pipx completions

pipx install uv


# clone voctomix
git clone https://github.com/voc/voctomix/
cd voctomix

uv venv --system-site-packages

uv pip install pycairo pygobject

uv pip install pygobject-stubs --config-settings=config=Gtk3,Gdk3
pip install pygobject

uv sync --dev

uv run -m voctocore -vv -i ../configs/2.0/minimal.ini
