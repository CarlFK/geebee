#
set -ex

host=${1:-pi}

# export ANSIBLE_STRATEGY=mitogen_linear

ansible-playbook \
    ansible/site.yml --inventory-file inventory/hosts \
    --user root --limit ${host} -vvv \
    --tags udev

    # --tags enable_sd

    # --vault-password-file ~/.ansible/pw_file.txt

