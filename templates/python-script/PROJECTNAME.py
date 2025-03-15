import click
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger()

# Main task function
def run_task():
    """Perform the task."""
    logger.info("Executing PROJECTNAME...")
    click.echo("PROJECTNAME executed successfully!")

# Main command-line entry point
@click.command()    
@click.option('--verbose', is_flag=True, help="Enable verbose output.")
def main(verbose, config):
    """Generic command-line interface."""
    
    # Enable verbose logging if the --verbose flag is provided
    if verbose:
        logger.setLevel(logging.DEBUG)
        logger.debug("Verbose output enabled.")
        
    # Run the task
    run_task()

if __name__ == "__main__":
    main()
