help:
	@IFS=$$'\n' ; \
        help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
        for help_line in $${help_lines[@]}; do \
            IFS=$$'#' ; \
            help_split=($$help_line) ; \
            help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
            help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
            printf "%-15s %s\n" $$help_command $$help_info ; \
        done

clean: ## statefile is already initilized
	@rm -rf .terraform

dev-apply: clean ## Create Dev Environment
	@terraform init -backend-config=env/dev-backend.tfvars
	@terraform apply -var-file=env/dev.tfvars -auto-approve

prod-apply:  clean ## Create Prod Environment
	@terraform init -backend-config=env/prod-backend.tfvars
	@terraform apply -var-file=env/prod.tfvars -auto-approve

dev-destroy: clean ## Destroy Dev Environment
	@terraform init -backend-config=env/dev-backend.tfvars
	@terraform destroy -var-file=env/dev.tfvars -auto-approve

prod-destroy: clean ## Destroy Prod Environment
	@terraform init -backend-config=env/prod-backend.tfvars
	@terraform destroy -var-file=env/prod.tfvars -auto-approve