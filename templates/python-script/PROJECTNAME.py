import click
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger()

def run_task():
    """Perform the task."""
    logger.info("Executing PROJECTNAME...")
    click.echo("PROJECTNAME executed successfully!")

@click.command()    
@click.option('--verbose', is_flag=True, help="Enable verbose output.")
def main(verbose):
    """Generic command-line interface."""
    
    if verbose:
        logger.setLevel(logging.DEBUG)
        logger.debug("Verbose output enabled.")
        
    run_task()

if __name__ == "__main__":
    main()
