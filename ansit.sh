#
set -ex

host=${1:-prs}

# export ANSIBLE_STRATEGY=mitogen_linear

ansible-playbook \
    ansible/site.yml --inventory-file inventory/hosts \
    --user root --limit ${host} -vvv \

    # --tags enable_sd

    # --tags udev


    # --vault-password-file ~/.ansible/pw_file.txt

