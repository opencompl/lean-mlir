import csv
import io

def compute_similarity(file_path):
    """
    Computes the similarity between the last two numerical columns of the provided data
    from a file.

    Args:
        file_path (str): The path to the file containing the data. The file must
                         be a CSV with a header row.

    Returns:
        None: Prints the results directly to the console.
    """
    total_runs = 0
    identical_runs = 0
    
    # Use a try-except block to handle potential file errors, such as the file
    # not being found.
    try:
        # Open the file and wrap it in a file-like object for the csv reader
        with open(file_path, 'r') as data_file:
            reader = csv.reader(data_file)

            # Skip the header row
            header = next(reader)
            print(f"Analyzing data from file '{file_path}' with columns: {', '.join(header)}")

            # Iterate through each row in the data
            for row in reader:
                # Skip any empty lines
                if not row:
                    continue
                
                # Get the two numbers to compare. We use a try-except block to handle
                # any potential errors in data format (e.g., non-numeric values).
                try:
                    # The columns 'SelectionDAG' and 'our' are the third and fourth columns,
                    # which are at index 2 and 3 in a 0-based list.
                    value_selection_dag = float(row[2])
                    value_our = float(row[3])
                    
                    # Increment the total number of runs
                    total_runs += 1
                    # Compare the two values and increment the identical_runs counter if they are the same
                    if value_selection_dag == value_our    :
                        identical_runs += 1
                        
                except (ValueError, IndexError) as e:
                    print(f"Skipping row due to data format error: {row}. Error: {e}")
    except FileNotFoundError:
        print(f"Error: The file '{file_path}' was not found.")
        return
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        return
    
    # Calculate the similarity percentage if there were any runs
    similarity_percentage = 0
    if total_runs > 0:
        similarity_percentage = (identical_runs / total_runs) * 100

    # Print the final results
    print("-" * 30)
    print(f"Total number of runs analyzed: {total_runs}")
    print(f"Number of runs where values were identical: {identical_runs}")
    print(f"Similarity Percentage: {similarity_percentage:.2f}%")
    print("-" * 30)

if __name__ == "__main__":
    compute_similarity("pivoted_instructions_for_plot.csv")
