describe('Test', () => {
  it('should succeed', (done) => {
    setTimeout(done, 1000);
  });

  it('should fail', () => {
    if (require('./module')) {
      throw new Error('Failed');
    }
  });
});