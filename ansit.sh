#
set -ex

host=${1:-opi}

# export ANSIBLE_STRATEGY=mitogen_linear

ansible-playbook \
    -vvv \
    ansible/site.yml --inventory-file inventory/hosts \
    --user root --limit ${host} \

    # --tags lcd

    # --tags ingest

    # --tags udev


    # --vault-password-file ~/.ansible/pw_file.txt

