import Movie from "../movie/Movie";

const Movies = ({ movies, updateMovieReview, message }) => {
  return (
    <div className="container mt-4">
      <div className="row">
        {Array.isArray(movies) && movies.length > 0 ? (
          movies.map((movie) => (
            <Movie
              key={movie._id}
              movie={movie}
              updateMovieReview={updateMovieReview}
            />
          ))
        ) : (
          <h2>{message || "No movies found"}</h2>
        )}
      </div>
    </div>
  );
};

export default Movies;