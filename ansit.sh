#
set -ex

host=${1:-opi}

# export ANSIBLE_STRATEGY=mitogen_linear

ansible-playbook \
    ansible/site.yml \
    -vvv \
    --inventory-file inventory/hosts \
    --vault-password-file ~/.ansible-vault \
    --user root --limit ${host} \
    --tags test_voc

    # --extra-vars=user_name=orangepi

    # --tags lcd

    # --tags ingest

    # --tags udev
    # --vault-password-file ~/.ansible/pw_file.txt
